package Controller.Home;

import dal.SaleOffDAO;
import dal.productDAO;
import model.Item;
import model.Product;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.sql.Date;
import model.SaleOff;

public class Cart extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String action = request.getParameter("action");
        model.User user = (model.User) session.getAttribute("user");
        if (user != null && ("TRUE".equalsIgnoreCase(user.getIsAdmin()) || "TRUE".equalsIgnoreCase(user.getIsStoreStaff()))) {
            session.setAttribute("errorMessage", "Quản trị viên và nhân viên cửa hàng không thể thêm hoặc mua sản phẩm.");
            request.getRequestDispatcher("search?action=productdetail&product_id=" + request.getParameter("product_id")).forward(request, response);
            return;
        }
        model.Cart cart = null;
        Object o = session.getAttribute("cart");

        if (o != null) {
            cart = (model.Cart) o;
        } else {
            cart = new model.Cart();
        }
        if (action == null || action.equalsIgnoreCase("addtocart")) {
            addToCart(request, cart);
            List<Item> list = cart.getItems();
            session.setAttribute("cart", cart);
            session.setAttribute("total", cart.getTotalMoney());
            session.setAttribute("size", list.size());
            updateFinalTotal(session, cart);
            session.setAttribute("successMessageAdd", "Sản phẩm đã được thêm vào giỏ hàng thành công.");
            request.getRequestDispatcher("search?action=productdetail&product_id=" + request.getParameter("product_id")).forward(request, response);
        } else if (action.equalsIgnoreCase("buynow")) {
            addToCart(request, cart);
            List<Item> list = cart.getItems();
            session.setAttribute("cart", cart);
            session.setAttribute("total", cart.getTotalMoney());
            session.setAttribute("size", list.size());
            updateFinalTotal(session, cart);
            response.sendRedirect("cart?action=showcart");
        } else if (action.equalsIgnoreCase("showcart")) {
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        } else if (action.equals("deletecart")) {
            String product_id = request.getParameter("product_id");
            cart.removeItem(product_id);
            List<Item> list = cart.getItems();
            session.setAttribute("cart", cart);
            session.setAttribute("total", cart.getTotalMoney());
            session.setAttribute("size", list.size());
            updateFinalTotal(session, cart);
            session.setAttribute("successMessageDelete", "Sản phẩm đã được xóa khỏi giỏ hàng thành công");
            response.sendRedirect("cart.jsp");
        } else if (action.equalsIgnoreCase("update")) {
            String productId = request.getParameter("product_id");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            cart.updateQuantity(productId, quantity);
            session.setAttribute("cart", cart);
            double total = cart.getTotalMoney();
            session.setAttribute("total", total);
            updateFinalTotal(session, cart);
            // Trả về JSON response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            Double finalTotal = (Double) session.getAttribute("finalTotal");

            response.getWriter().write("{"
                    + "\"total\":" + total + ","
                    + "\"finalTotal\":" + (finalTotal != null ? finalTotal : total)
                    + "}");
            return;
        } else if (action.equalsIgnoreCase("applydiscount")) {
            applyDiscount(request, session, cart);
            response.sendRedirect("cart.jsp");
        } else if (action.equalsIgnoreCase("removediscount")) {
            session.removeAttribute("discountCode");
            session.removeAttribute("discountAmount");
            session.removeAttribute("finalTotal");
            response.sendRedirect("cart.jsp");
        }
        session.setAttribute("cart", cart);
    }

    private void addToCart(HttpServletRequest request, model.Cart cart) {
        String Squantity = request.getParameter("quantity");
        String product_id = request.getParameter("product_id");
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        try {
            int quantity = Integer.parseInt(Squantity);
            productDAO pdao = new productDAO();
            Product product = pdao.getProductByID(product_id);
            Item item = new Item(product, quantity, size, color);
            cart.addItem(item);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void applyDiscount(HttpServletRequest request, HttpSession session, model.Cart cart) {
        String discountCode = request.getParameter("discountCode");
        double total = cart.getTotalMoney();

        if (discountCode == null || discountCode.trim().isEmpty()) {
            session.setAttribute("error", "❌ Mã giảm giá không được để trống.");
            return;
        }

        Date today = Date.valueOf(LocalDate.now());
        SaleOffDAO dao = new SaleOffDAO();
        SaleOff discount = dao.getValidSaleOff(discountCode.trim(), today);

        if (discount == null) {
            session.setAttribute("error", "❌ Mã giảm giá không hợp lệ hoặc đã hết hạn.");
            return;
        }

        double discountAmount;
        if ("fixed".equalsIgnoreCase(discount.getDiscountType())) {
            discountAmount = discount.getDiscountValue();
        } else {
            discountAmount = total * discount.getDiscountValue() / 100.0;
            if (discountAmount > discount.getMaxDiscount()) {
                discountAmount = discount.getMaxDiscount();
            }
        }

        double finalTotal = Math.max(0, total - discountAmount);

        session.setAttribute("discountCode", discountCode);
        session.setAttribute("discountAmount", discountAmount);
        session.setAttribute("finalTotal", finalTotal);

        dao.reduceQuantity(discount.getSaleId());
        session.removeAttribute("error");
    }

    private void updateFinalTotal(HttpSession session, model.Cart cart) {
        Double discountAmount = (Double) session.getAttribute("discountAmount");
        if (discountAmount != null) {
            double finalTotal = Math.max(0, cart.getTotalMoney() - discountAmount);
            session.setAttribute("finalTotal", finalTotal);
        } else {
            session.removeAttribute("finalTotal");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
