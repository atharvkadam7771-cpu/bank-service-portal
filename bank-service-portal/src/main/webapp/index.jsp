<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bank Service Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            color: #1f2937;
        }

        .header {
            background: #0b5ed7;
            color: white;
            padding: 22px 8%;
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
        }

        .header p {
            margin: 6px 0 0;
            opacity: 0.9;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 35px auto;
        }

        .intro {
            text-align: center;
            margin-bottom: 28px;
        }

        .intro h2 {
            margin-bottom: 8px;
        }

        .intro p {
            color: #667085;
        }

        .services {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.07);
            text-align: center;
        }

        .card h3 {
            color: #0b5ed7;
            margin-top: 0;
        }

        .form-box {
            background: white;
            padding: 28px;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.07);
            max-width: 600px;
            margin: auto;
        }

        .form-box h2 {
            margin-top: 0;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 6px;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #cfd6df;
            border-radius: 7px;
            font-size: 15px;
        }

        button {
            width: 100%;
            margin-top: 22px;
            padding: 13px;
            border: 0;
            border-radius: 7px;
            background: #0b5ed7;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #084db2;
        }

        .footer {
            text-align: center;
            padding: 20px;
            color: #667085;
        }

        @media (max-width: 800px) {
            .services {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 500px) {
            .services {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<div class="header">
    <h1>Bank Service Portal</h1>
    <p>Simple and secure banking service request portal</p>
</div>

<div class="container">

    <div class="intro">
        <h2>Bank Facilities</h2>
        <p>Select a service and submit your request.</p>
    </div>

    <div class="services">
        <div class="card">
            <h3>Balance</h3>
            <p>Request bank balance checking service.</p>
        </div>

        <div class="card">
            <h3>Transfer</h3>
            <p>Request a bank transfer service.</p>
        </div>

        <div class="card">
            <h3>Complaint</h3>
            <p>File a banking-related complaint.</p>
        </div>

        <div class="card">
            <h3>UPI Setup</h3>
            <p>Request assistance for UPI setup.</p>
        </div>
    </div>

    <div class="form-box">
        <h2>Service Request</h2>

        <form action="request" method="post">
            <label for="service">Select Service</label>
            <select id="service" name="service" required>
                <option value="">-- Select a service --</option>
                <option value="Bank Balance Checking">Bank Balance Checking</option>
                <option value="Bank Transfer">Bank Transfer</option>
                <option value="File Complaint">File Complaint</option>
                <option value="UPI Setup">UPI Setup</option>
            </select>

            <label for="name">Name</label>
            <input type="text" id="name" name="name"
                   placeholder="Enter your name" required>

            <label for="contact">Contact Number</label>
            <input type="tel" id="contact" name="contact"
                   placeholder="Enter 10-digit contact number"
                   pattern="[0-9]{10}" maxlength="10" required>

            <button type="submit">Submit Service Request</button>
        </form>
    </div>

</div>

<div class="footer">
    Experiment 10 - End-to-End DevOps Pipeline
</div>

</body>
</html>
