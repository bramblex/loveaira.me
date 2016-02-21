module Template.Home where

import Prelude (show)
import Data.Maybe
import Template.Base

index :: Template
index = do
  base
  extend "body" $ do

    t_p [] $ t_a [a_href := "https://github.com/bramblex/loveaira.me"] $ text "GitHub 项目地址"

    t_p [] $ t_a [a_href := "/article/"] $ text "博客列表"

    t_p [] $ text "这是一个用纯 PureScript 实现的简易 Web 框架。还有好多蛋疼的问题正在解决中。现在就先凑活用了"

