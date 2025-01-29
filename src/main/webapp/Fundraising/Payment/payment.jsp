<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report</title>
    <link rel="stylesheet" href="payment.css">
</head>

<body>
<div class="container">
    <h1>Payment</h1>
    <form>
        <div class="form-group">
            <label for="amount">Amount</label>
            <input type="text" id="amount" name="amount">
        </div>
        <div class="form-group">
            <label for="description">Description</label>
            <input type="text" id="description" name="description">
        </div>
        <div class="form-group">
            <label for="file-upload">Upload File</label>
            <input type="file" id="file-upload" name="file-upload">
        </div>
        <div class="button">
            <button type="submit" class="submit-button">Submit</button>
            <button type="button" class="cancel-button">Cancel</button>
        </div>
    </form>
</div>
</body>
</html>