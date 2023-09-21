from django.contrib import admin
from django.urls import path, include
from rest_framework.permissions import AllowAny
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from .views import ping


schema_view = get_schema_view(
    openapi.Info(
        title="Movies API",
        default_version="v1",
    ),
    public=True,
    permission_classes=(AllowAny,),
)


urlpatterns = [
    path('admin/', admin.site.urls),
    path('ping/', ping, name="ping"),
    path(
        "swagger-docs/",
        schema_view.with_ui("swagger", cache_timeout=0),
        name="schema-swagger-ui",
    ),
    path("", include("movies.urls")),
]
