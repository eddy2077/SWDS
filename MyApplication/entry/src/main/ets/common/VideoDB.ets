import { VideoItem } from './DataModels'

export const videoDB: Record<string, Record<string, VideoItem[]>> = {
  '机器学习': {
    '线性回归': [
      { title: '线性回归从零讲起，一小时彻底搞懂', platform: 'B站', duration: '58:30', author: '李沐说AI', level: '入门', url: 'https://search.bilibili.com/all?keyword=线性回归+讲解' },
      { title: 'Linear Regression - StatQuest', platform: 'YouTube', duration: '12:45', author: 'StatQuest', level: '入门', url: 'https://www.youtube.com/results?search_query=linear+regression+statquest' },
    ],
    '逻辑回归': [
      { title: '逻辑回归详解：从原理到代码实现', platform: 'B站', duration: '42:15', author: '跟李沐学AI', level: '入门', url: 'https://search.bilibili.com/all?keyword=逻辑回归+详解' },
      { title: 'Logistic Regression 完整教程', platform: 'Coursera', duration: '35:00', author: '吴恩达', level: '入门', url: 'https://search.bilibili.com/all?keyword=吴恩达+逻辑回归' },
    ],
    '决策树': [
      { title: '决策树算法原理与ID3/C4.5/CART对比', platform: 'B站', duration: '38:20', author: '菜菜的sklearn', level: '入门', url: 'https://search.bilibili.com/all?keyword=决策树+算法原理' },
      { title: 'Decision Trees - StatQuest', platform: 'YouTube', duration: '15:30', author: 'StatQuest', level: '入门', url: 'https://www.youtube.com/results?search_query=decision+trees+statquest' },
    ],
    'SVM': [
      { title: '支持向量机SVM从入门到精通', platform: 'B站', duration: '65:40', author: '跟李沐学AI', level: '进阶', url: 'https://search.bilibili.com/all?keyword=SVM+支持向量机+讲解' },
      { title: 'SVM核函数详解', platform: 'B站', duration: '33:15', author: '数学家的人工智能', level: '进阶', url: 'https://search.bilibili.com/all?keyword=SVM+核函数' },
    ],
    'K-Means': [
      { title: 'K-Means聚类算法原理与Python实现', platform: 'B站', duration: '30:25', author: '菜菜的sklearn', level: '入门', url: 'https://search.bilibili.com/all?keyword=K-Means+聚类' },
      { title: 'K-Means与肘部法则选择最优K值', platform: 'B站', duration: '22:10', author: '机器学习入门', level: '入门', url: 'https://search.bilibili.com/all?keyword=K-Means+肘部法则' },
    ],
    'PCA': [
      { title: 'PCA主成分分析：降维的核心方法', platform: 'B站', duration: '40:30', author: '3Blue1Brown中文', level: '进阶', url: 'https://search.bilibili.com/all?keyword=PCA+主成分分析' },
      { title: 'Principal Component Analysis - Coursera', platform: 'Coursera', duration: '22:00', author: '吴恩达', level: '入门', url: 'https://search.bilibili.com/all?keyword=吴恩达+PCA' },
    ],
    'CNN': [
      { title: '卷积神经网络CNN原理详解与实战', platform: 'B站', duration: '55:40', author: '跟李沐学AI', level: '进阶', url: 'https://search.bilibili.com/all?keyword=CNN+卷积神经网络+详解' },
      { title: 'Convolutional Neural Networks - Coursera', platform: 'Coursera', duration: '45:00', author: '吴恩达', level: '入门', url: 'https://search.bilibili.com/all?keyword=吴恩达+CNN' },
    ],
    'Transformer': [
      { title: 'Transformer架构详解：Attention is All You Need', platform: 'B站', duration: '62:30', author: '跟李沐学AI', level: '进阶', url: 'https://search.bilibili.com/all?keyword=Transformer+详解+李沐' },
      { title: 'Attention is All You Need 论文精读', platform: 'B站', duration: '75:00', author: '跟李沐学AI', level: '高级', url: 'https://search.bilibili.com/all?keyword=Transformer+论文精读' },
    ],
  },
  '中国历史': {
    '秦汉': [
      { title: '秦汉史精讲：从秦始皇到汉武帝', platform: 'B站', duration: '85:30', author: '历史老师讲历史', level: '入门', url: 'https://search.bilibili.com/all?keyword=秦汉+历史+精讲' },
      { title: '秦始皇统一六国的历史意义', platform: '中国大学MOOC', duration: '42:00', author: '北京大学', level: '入门', url: 'https://search.bilibili.com/all?keyword=秦始皇+统一六国' },
    ],
    '儒家': [
      { title: '儒家思想核心：仁义礼智信全解读', platform: 'B站', duration: '55:20', author: '国学大讲堂', level: '入门', url: 'https://search.bilibili.com/all?keyword=儒家思想+核心+解读' },
      { title: '孔子与论语：中国人的精神底色', platform: '中国大学MOOC', duration: '38:00', author: '复旦大学', level: '进阶', url: 'https://search.bilibili.com/all?keyword=孔子+论语+课程' },
    ],
    '唐宋': [
      { title: '大唐盛世：贞观之治到开元盛世', platform: 'B站', duration: '72:00', author: '历史老师讲历史', level: '入门', url: 'https://search.bilibili.com/all?keyword=唐朝+盛世+贞观之治' },
      { title: '唐诗宋词：中国文学的黄金时代', platform: '中国大学MOOC', duration: '48:30', author: '南京大学', level: '入门', url: 'https://search.bilibili.com/all?keyword=唐诗宋词+文学' },
    ],
    '明清': [
      { title: '明朝那些事儿：从朱元璋到崇祯', platform: 'B站', duration: '68:40', author: '历史漫谈', level: '入门', url: 'https://search.bilibili.com/all?keyword=明朝+历史+精讲' },
      { title: '康乾盛世的真相与反思', platform: '中国大学MOOC', duration: '35:00', author: '清华大学', level: '进阶', url: 'https://search.bilibili.com/all?keyword=康乾盛世+反思' },
    ],
    '鸦片战争': [
      { title: '鸦片战争：中国近代史的开端', platform: 'B站', duration: '52:30', author: '近代史讲堂', level: '入门', url: 'https://search.bilibili.com/all?keyword=鸦片战争+近代史' },
      { title: '南京条约与不平等条约体系', platform: '中国大学MOOC', duration: '38:00', author: '北京大学', level: '进阶', url: 'https://search.bilibili.com/all?keyword=南京条约+不平等条约' },
    ],
    '辛亥革命': [
      { title: '辛亥革命：推翻千年帝制的伟大变革', platform: 'B站', duration: '58:20', author: '近代史讲堂', level: '入门', url: 'https://search.bilibili.com/all?keyword=辛亥革命+讲解' },
      { title: '孙中山与三民主义', platform: '中国大学MOOC', duration: '42:00', author: '中山大学', level: '入门', url: 'https://search.bilibili.com/all?keyword=孙中山+三民主义' },
    ],
  },
  'Python编程': {
    '变量与类型': [
      { title: 'Python变量与数据类型：零基础入门', platform: 'B站', duration: '32:15', author: '小甲鱼', level: '入门', url: 'https://search.bilibili.com/all?keyword=Python+变量+数据类型+入门' },
      { title: 'Python for Everybody - Coursera', platform: 'Coursera', duration: '40:00', author: 'Dr. Chuck', level: '入门', url: 'https://search.bilibili.com/all?keyword=Python+for+Everybody+课程' },
    ],
    '控制流': [
      { title: 'Python条件语句与循环详解', platform: 'B站', duration: '28:30', author: '小甲鱼', level: '入门', url: 'https://search.bilibili.com/all?keyword=Python+条件语句+循环' },
      { title: 'Python控制流：if/for/while完全指南', platform: '慕课网', duration: '35:00', author: 'Python入门', level: '入门', url: 'https://search.bilibili.com/all?keyword=Python+控制流+指南' },
    ],
    '列表推导': [
      { title: 'Python列表推导式：一行代码的优雅', platform: 'B站', duration: '20:45', author: 'Python程序员', level: '入门', url: 'https://search.bilibili.com/all?keyword=Python+列表推导式' },
      { title: '列表推导、字典推导与生成器表达式', platform: 'B站', duration: '25:30', author: '小甲鱼', level: '进阶', url: 'https://search.bilibili.com/all?keyword=Python+推导式+生成器' },
    ],
    'Lambda': [
      { title: 'Python Lambda与函数式编程详解', platform: 'B站', duration: '30:20', author: 'Python程序员', level: '进阶', url: 'https://search.bilibili.com/all?keyword=Python+Lambda+函数式' },
      { title: 'map/filter/reduce：Python函数式三剑客', platform: 'B站', duration: '22:15', author: '小甲鱼', level: '入门', url: 'https://search.bilibili.com/all?keyword=Python+map+filter+reduce' },
    ],
    '类定义': [
      { title: 'Python面向对象编程：类与对象入门', platform: 'B站', duration: '45:30', author: '小甲鱼', level: '入门', url: 'https://search.bilibili.com/all?keyword=Python+面向对象+类' },
      { title: 'Python OOP - Coursera', platform: 'Coursera', duration: '35:00', author: 'UMich', level: '入门', url: 'https://search.bilibili.com/all?keyword=Python+面向对象+Coursera' },
    ],
    '继承与多态': [
      { title: 'Python继承与多态：OOP进阶核心', platform: 'B站', duration: '38:20', author: 'Python程序员', level: '进阶', url: 'https://search.bilibili.com/all?keyword=Python+继承+多态' },
      { title: 'MRO方法解析顺序与多继承', platform: 'B站', duration: '25:30', author: 'Python进阶', level: '高级', url: 'https://search.bilibili.com/all?keyword=Python+MRO+多继承' },
    ],
    '装饰器': [
      { title: 'Python装饰器详解：从原理到实战', platform: 'B站', duration: '42:15', author: 'Python程序员', level: '进阶', url: 'https://search.bilibili.com/all?keyword=Python+装饰器+详解' },
      { title: '函数装饰器与类装饰器完整教程', platform: 'B站', duration: '35:40', author: 'Python进阶', level: '进阶', url: 'https://search.bilibili.com/all?keyword=Python+函数装饰器+类装饰器' },
    ],
    '文件IO': [
      { title: 'Python文件读写与with语句详解', platform: 'B站', duration: '30:20', author: '小甲鱼', level: '入门', url: 'https://search.bilibili.com/all?keyword=Python+文件读写+with' },
      { title: 'pathlib与CSV/JSON文件处理实战', platform: 'B站', duration: '35:15', author: 'Python程序员', level: '进阶', url: 'https://search.bilibili.com/all?keyword=Python+pathlib+CSV+JSON' },
    ],
  },
  '前端开发': {
    '语义化': [
      { title: 'HTML5语义化标签完全指南', platform: 'B站', duration: '28:30', author: '前端小智', level: '入门', url: 'https://search.bilibili.com/all?keyword=HTML5+语义化+标签' },
      { title: 'Web无障碍与语义化最佳实践', platform: '慕课网', duration: '35:00', author: '前端学院', level: '进阶', url: 'https://search.bilibili.com/all?keyword=Web+无障碍+语义化' },
    ],
    'Flexbox': [
      { title: 'Flexbox布局完全指南：从入门到实战', platform: 'B站', duration: '45:20', author: '前端小智', level: '入门', url: 'https://search.bilibili.com/all?keyword=Flexbox+布局+指南' },
      { title: 'CSS Flexbox可视化教程', platform: 'B站', duration: '32:15', author: 'CSS魔法师', level: '入门', url: 'https://search.bilibili.com/all?keyword=CSS+Flexbox+可视化' },
    ],
    'ES6+': [
      { title: 'ES6完全教程：从入门到精通', platform: 'B站', duration: '65:00', author: '前端小智', level: '入门', url: 'https://search.bilibili.com/all?keyword=ES6+教程+入门' },
      { title: 'Promise与async/await深入理解', platform: '慕课网', duration: '38:00', author: '前端学院', level: '进阶', url: 'https://search.bilibili.com/all?keyword=Promise+async+await' },
    ],
    'React': [
      { title: 'React18新特性与Hooks完全指南', platform: 'B站', duration: '55:30', author: '前端小智', level: '进阶', url: 'https://search.bilibili.com/all?keyword=React18+Hooks+指南' },
      { title: 'React入门到实战 - Coursera', platform: 'Coursera', duration: '45:00', author: 'Meta', level: '入门', url: 'https://search.bilibili.com/all?keyword=React+入门+Coursera' },
    ],
    'Vue': [
      { title: 'Vue3组合式API完全教程', platform: 'B站', duration: '50:20', author: '前端小智', level: '进阶', url: 'https://search.bilibili.com/all?keyword=Vue3+组合式API' },
      { title: 'Vue3从零搭建企业级项目', platform: '慕课网', duration: '62:00', author: '前端学院', level: '进阶', url: 'https://search.bilibili.com/all?keyword=Vue3+企业级项目' },
    ],
    'TypeScript': [
      { title: 'TypeScript入门与高级类型详解', platform: 'B站', duration: '48:15', author: '前端小智', level: '进阶', url: 'https://search.bilibili.com/all?keyword=TypeScript+入门+高级类型' },
      { title: 'TypeScript泛型与类型体操实战', platform: 'B站', duration: '42:30', author: 'TypeScript社区', level: '进阶', url: 'https://search.bilibili.com/all?keyword=TypeScript+泛型+类型体操' },
    ],
  },
  '产品经理': {
    '用户画像': [
      { title: '用户画像构建方法论：从0到1', platform: 'B站', duration: '42:20', author: '产品经理老王', level: '入门', url: 'https://search.bilibili.com/all?keyword=用户画像+构建+方法论' },
      { title: 'Persona用户画像实战案例', platform: '慕课网', duration: '35:00', author: '产品学院', level: '入门', url: 'https://search.bilibili.com/all?keyword=Persona+用户画像+实战' },
    ],
    'PRD': [
      { title: 'PRD产品需求文档写作指南', platform: 'B站', duration: '55:30', author: '产品经理老王', level: '入门', url: 'https://search.bilibili.com/all?keyword=PRD+产品需求文档+写作' },
      { title: '从需求到PRD：产品经理核心技能', platform: '中国大学MOOC', duration: '38:00', author: '浙江大学', level: '入门', url: 'https://search.bilibili.com/all?keyword=PRD+需求+产品经理' },
    ],
    '优先级': [
      { title: 'RICE模型：需求优先级排序实战', platform: 'B站', duration: '28:15', author: '产品经理老王', level: '入门', url: 'https://search.bilibili.com/all?keyword=RICE+优先级+产品经理' },
      { title: 'MoSCoW与Kano模型对比', platform: '慕课网', duration: '32:00', author: '产品学院', level: '进阶', url: 'https://search.bilibili.com/all?keyword=MoSCoW+Kano+优先级' },
    ],
    '竞品分析': [
      { title: '竞品分析框架与SWOT实战', platform: 'B站', duration: '45:20', author: '产品经理老王', level: '进阶', url: 'https://search.bilibili.com/all?keyword=竞品分析+SWOT+产品经理' },
      { title: '如何写出一份高质量的竞品分析报告', platform: 'B站', duration: '38:00', author: '产品学院', level: '入门', url: 'https://search.bilibili.com/all?keyword=竞品分析+报告+写作' },
    ],
    'A/B测试': [
      { title: 'A/B测试从入门到精通', platform: 'B站', duration: '52:30', author: '增长黑客', level: '进阶', url: 'https://search.bilibili.com/all?keyword=A/B测试+产品经理' },
      { title: '实验设计与统计显著性', platform: 'Coursera', duration: '30:00', author: 'Google', level: '进阶', url: 'https://search.bilibili.com/all?keyword=A/B测试+统计显著性' },
    ],
    '敏捷开发': [
      { title: 'Scrum敏捷开发入门完全指南', platform: 'B站', duration: '48:15', author: '敏捷教练', level: '入门', url: 'https://search.bilibili.com/all?keyword=Scrum+敏捷开发+入门' },
      { title: '产品经理如何参与敏捷迭代', platform: '慕课网', duration: '35:00', author: '产品学院', level: '入门', url: 'https://search.bilibili.com/all?keyword=敏捷+产品经理+迭代' },
    ],
  },
}
