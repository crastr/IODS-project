# Alexey Afonin
# 06/11/2023
#A description of the file

library(tidyverse)

# The combinations are 
# Stra
# st_os     Organized Studying        ~ST01+ST09+ST17+ST25
# st_tm     Time Management           ~ST04+ST12+ST20+ST28
# Stra      Strategic approach        ~st_os+st_tm
# Stra_adj  Strategic_adjusted        ~Stra/8
 
# Surf
# su_lp    Lack of Purpose           ~SU02+SU10+SU18+SU26
# su_um    Unrelated Memorising      ~SU05+SU13+SU21+SU29
# su_sb    Syllabus-boundness        ~SU08+SU16+SU24+SU32
# Surf     Surface approach          ~su_lp+su_um+su_sb
# Surf_adj Surface_adjusted          ~Surf/12

# Deep     
# Deep     Deep approach             ~d_sm+d_ri+d_ue
# d_sm     Seeking Meaning           ~D03+D11+D19+D27
# d_ri     Relating Ideas            ~D07+D14+D22+D30
# d_ue     Use of Evidence           ~D06+D15+D23+D31

# Attitude
# attitude Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj

JYTOPKYS3_data_2022 <- read_tsv("./JYTOPKYS3-data.txt")


JYTOPKYS3_data_2022 <- JYTOPKYS3_data_2022 %>%  
  filter(Points !=0) %>% 
  mutate(stra = (ST01 + ST09 + ST17 + ST25 + ST04 + ST12 + ST20 + ST28)/8) %>% 
  mutate(surf = (SU02 + SU10 + SU18 + SU26 + SU05 + SU13 + SU21 + SU29 + SU08 + SU16 + SU24 + SU32)/12) %>% 
  mutate(deep = (D03 + D11 + D19 + D27 + D07 + D14 + D22 + D30 + D06 + D15 + D23 + D31)/12) %>% 
  mutate(attitude = (Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj)/10) %>%
  select(gender, age = Age, attitude, deep, stra, surf, points = Points)




write_csv(JYTOPKYS3_data_2022,"./learning2014_AA.csv")
