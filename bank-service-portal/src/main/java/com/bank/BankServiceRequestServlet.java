package com.bank;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BankServiceRequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String service = request.getParameter("service");
        String name = request.getParameter("name");
        String contact = request.getParameter("contact");

        if (service == null || service.isBlank()
                || name == null || name.isBlank()
                || contact == null || !contact.matches("\\d{10}")) {

            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

            try (PrintWriter out = response.getWriter()) {

                out.println("<!DOCTYPE html>");
                out.println("<html><head><title>Invalid Request</title>");

                out.println("<style>");
                out.println("body{font-family:Arial;text-align:center;padding:60px;"
                        + "background:#f4f7fb}");

                out.println(".box{background:white;padding:30px;"
                        + "max-width:500px;margin:auto;border-radius:12px;"
                        + "box-shadow:0 4px 14px rgba(0,0,0,.08)}");

                out.println("a{color:#0b5ed7;text-decoration:none}");
                out.println("</style></head><body>");

                out.println("<div class='box'>");
                out.println("<h2>Invalid Request</h2>");
                out.println("<p>Please enter all details correctly.</p>");
                out.println("<a href='index.jsp'>Go Back</a>");
                out.println("</div>");

                out.println("</body></html>");
            }

            return;
        }

        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html><head><meta charset='UTF-8'>");

            out.println("<meta name='viewport' "
                    + "content='width=device-width, initial-scale=1.0'>");

            out.println("<title>Request Submitted</title>");

            out.println("<style>");

            out.println("body{font-family:Arial,sans-serif;"
                    + "background:#f4f7fb;margin:0;"
                    + "display:flex;justify-content:center;"
                    + "align-items:center;min-height:100vh}");

            out.println(".box{background:white;padding:40px;"
                    + "text-align:center;border-radius:14px;"
                    + "max-width:550px;width:90%;"
                    + "box-shadow:0 4px 16px rgba(0,0,0,.08)}");

            out.println(".success{color:#198754;font-size:30px;"
                    + "margin-bottom:20px}");

            out.println(".details{background:#f4f7fb;padding:18px;"
                    + "border-radius:8px;text-align:left;line-height:1.8}");

            out.println("a{display:inline-block;margin-top:22px;"
                    + "padding:12px 20px;background:#0b5ed7;"
                    + "color:white;text-decoration:none;border-radius:7px}");

            out.println("</style></head><body>");

            out.println("<div class='box'>");

            out.println("<div class='success'>"
                    + "Request Submitted Successfully!"
                    + "</div>");

            out.println("<p>Your banking service request has been received.</p>");

            out.println("<div class='details'>");

            out.println("<b>Name:</b> "
                    + escapeHtml(name) + "<br>");

            out.println("<b>Contact:</b> "
                    + escapeHtml(contact) + "<br>");

            out.println("<b>Service:</b> "
                    + escapeHtml(service));

            out.println("</div>");

            out.println("<a href='index.jsp'>"
                    + "Submit Another Request"
                    + "</a>");

            out.println("</div>");

            out.println("</body></html>");
        }
    }

    private String escapeHtml(String value) {

        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}