import '../model/category.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel1 = CategoryModel();

  categoryModel1.categoryName = "Business";
  categoryModel1.imageUrl =
      "https://images.pexels.com/photos/1737957/pexels-photo-1737957.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";
  category.add(categoryModel1);

  CategoryModel categoryModel2 = CategoryModel();
  categoryModel2.categoryName = "Entertainment";
  categoryModel2.imageUrl =
      "https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  category.add(categoryModel2);

  CategoryModel categoryModel3 = CategoryModel();
  categoryModel3.categoryName = "General";
  categoryModel3.imageUrl =
      "https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60";
  category.add(categoryModel3);

  CategoryModel categoryModel4 = CategoryModel();
  categoryModel4.categoryName = "Health";
  categoryModel4.imageUrl =
      "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80";
  category.add(categoryModel4);

  CategoryModel categoryModel5 = CategoryModel();
  categoryModel5.categoryName = "Science";
  categoryModel5.imageUrl =
      "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80";
  category.add(categoryModel5);

  CategoryModel categoryModel6 = CategoryModel();
  categoryModel6.categoryName = "Sports";
  categoryModel6.imageUrl =
      "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  category.add(categoryModel6);

  CategoryModel categoryModel7 = CategoryModel();
  categoryModel7.categoryName = "Technology";
  categoryModel7.imageUrl =
      "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  category.add(categoryModel7);

  return category;
}
