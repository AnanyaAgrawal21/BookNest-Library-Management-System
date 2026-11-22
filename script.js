function showPage(pageId) {
    document.querySelectorAll(".page").forEach(page => {
        page.classList.add("hidden");
    });

    document.getElementById(pageId).classList.remove("hidden");
}

function searchBooks() {
    let input = document.getElementById("searchBook");
    let filter = input.value.toLowerCase();

    let table = document.getElementById("bookTable");
    let rows = table.getElementsByTagName("tr");

    for (let i = 1; i < rows.length; i++) {
        let title = rows[i].getElementsByTagName("td")[1];

        if (title) {
            let text = title.textContent.toLowerCase();

            rows[i].style.display =
                text.includes(filter) ? "" : "none";
        }
    }
}

function issueBook() {
    let memberId = document.getElementById("memberId").value;
    let bookId = document.getElementById("bookId").value;

    if (!memberId || !bookId) {
        document.getElementById("message").textContent =
            "Please enter Member ID and Book ID.";
        return;
    }

    document.getElementById("message").textContent =
        "Demo request created. Connect ISSUE_BOOK procedure for actual database operation.";
}

function returnBook() {
    document.getElementById("message").textContent =
        "Demo return request. Connect RETURN_BOOK procedure for actual database operation.";
}

function changeRole() {
    let role = document.getElementById("role").value;

    if (role === "member") {
        alert("Member mode selected. Only member-specific records should be displayed after backend authentication.");
    } else {
        alert("Admin / Librarian mode selected.");
    }
}