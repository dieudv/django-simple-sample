from django.shortcuts import render
from django.template.exceptions import TemplateDoesNotExist

def index(request, path=None):
    if path:
        try:
            return render(request, '{}.html'.format(path))
        except TemplateDoesNotExist:
            try:
                return render(request, '{}/index.html'.format(path))
            except TemplateDoesNotExist:
                return render(request, '404.html')
    else:
        return render(request, 'index.html')