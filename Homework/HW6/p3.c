struct s {
  int key;
  int value;
  struct s *next;
};

int problem3(struct s *list, int key)
{
  while (list && (list->key != key)) {
    list = list->next;
  }

  return list ? list->value : -1;
}
