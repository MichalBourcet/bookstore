from django.shortcuts import render
from django.contrib.auth.mixins import (  
    LoginRequiredMixin,
    PermissionRequiredMixin  
)
from django.views.generic import ListView, DetailView

# Create your views here.
from .models import Book

class BookListView(LoginRequiredMixin, ListView):
    model = Book
    context_object_name = "book_list"
    template_name = "books/book_list.html"
    login_url = "account_login"


class BookDetailView(PermissionRequiredMixin, DetailView):
    model = Book
    context_object_name = "book"  
    template_name = "books/book_detail.html"
    permission_required = "books.special_status"

