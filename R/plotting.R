my_red <- "#E13242"
my_orange <- "#F67E14"
my_yellow <- "#FDE724"
my_green <- "#49C26D"
my_teal <- "#1EA187"
my_blue <- "#37659D"

colors_sex <- c("Female" = my_red, "Male" = my_blue)
color_scale_sex <- scale_color_manual(name = "Sex", values = colors_sex)
fill_scale_sex <- scale_fill_manual(name = "Sex", values = colors_sex)