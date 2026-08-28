import { TopicData, GraphNode, GraphEdge, PathStep, QuizItem, L1Item, L2Item } from './DataModels'

export const topicDB: Record<string, TopicData> = {
  '机器学习': {
    nodes: [
      { id: 'ml', label: '机器学习', type: 'center', desc: '让计算机从数据中自动学习规律并做出预测的技术', status: 'in-progress', related: ['监督学习','无监督学习','深度学习','强化学习'] },
      { id: 'supervised', label: '监督学习', type: 'l1', desc: '使用带标签的数据训练模型，用于分类和回归任务', status: 'in-progress', related: ['线性回归','逻辑回归','决策树','SVM'] },
      { id: 'unsupervised', label: '无监督学习', type: 'l1', desc: '从无标签数据中发现隐藏结构和模式', status: 'not-started', related: ['K-Means','PCA','聚类分析'] },
      { id: 'deep', label: '深度学习', type: 'l1', desc: '基于多层神经网络的表示学习方法', status: 'not-started', related: ['CNN','RNN','Transformer'] },
      { id: 'rl', label: '强化学习', type: 'l1', desc: '通过与环境交互获得奖励来学习最优策略', status: 'not-started', related: ['Q-Learning','策略梯度'] },
      { id: 'linreg', label: '线性回归', type: 'l2', desc: '用线性函数拟合数据，用于预测连续值', status: 'completed', related: ['监督学习','梯度下降'] },
      { id: 'logreg', label: '逻辑回归', type: 'l2', desc: '分类算法，输出概率值用于二分类或多分类', status: 'completed', related: ['监督学习','SVM'] },
      { id: 'dtree', label: '决策树', type: 'l2', desc: '基于特征划分的树形决策结构', status: 'in-progress', related: ['监督学习','随机森林'] },
      { id: 'svm', label: 'SVM', type: 'l2', desc: '支持向量机，寻找最优分类超平面', status: 'not-started', related: ['监督学习','逻辑回归'] },
      { id: 'kmeans', label: 'K-Means', type: 'l2', desc: '基于距离的聚类算法，将数据分为K个簇', status: 'not-started', related: ['无监督学习','聚类分析'] },
      { id: 'pca', label: 'PCA', type: 'l2', desc: '主成分分析，降维和特征提取方法', status: 'not-started', related: ['无监督学习','特征工程'] },
      { id: 'cnn', label: 'CNN', type: 'l2', desc: '卷积神经网络，擅长图像识别和计算机视觉', status: 'not-started', related: ['深度学习','计算机视觉'] },
      { id: 'rnn', label: 'RNN', type: 'l2', desc: '循环神经网络，处理序列数据的深度学习模型', status: 'not-started', related: ['深度学习','NLP'] },
      { id: 'transformer', label: 'Transformer', type: 'l2', desc: '基于注意力机制的模型架构，GPT/BERT 的基础', status: 'not-started', related: ['深度学习','注意力机制'] },
      { id: 'qlearn', label: 'Q-Learning', type: 'l2', desc: '基于值函数的强化学习算法', status: 'not-started', related: ['强化学习','AlphaGo'] },
    ],
    edges: [
      { from: 'ml', to: 'supervised' }, { from: 'ml', to: 'unsupervised' }, { from: 'ml', to: 'deep' }, { from: 'ml', to: 'rl' },
      { from: 'supervised', to: 'linreg' }, { from: 'supervised', to: 'logreg' }, { from: 'supervised', to: 'dtree' }, { from: 'supervised', to: 'svm' },
      { from: 'unsupervised', to: 'kmeans' }, { from: 'unsupervised', to: 'pca' },
      { from: 'deep', to: 'cnn' }, { from: 'deep', to: 'rnn' }, { from: 'deep', to: 'transformer' },
      { from: 'rl', to: 'qlearn' },
      { from: 'logreg', to: 'svm' }, { from: 'cnn', to: 'rnn' }, { from: 'rnn', to: 'transformer' },
    ],
    path: [
      { id: 'linreg', title: '线性回归', desc: '机器学习最基础的入门算法', topics: ['最小二乘法','梯度下降','损失函数'], status: 'completed' },
      { id: 'logreg', title: '逻辑回归', desc: '从回归到分类的桥梁', topics: ['Sigmoid函数','交叉熵','多分类'], status: 'completed' },
      { id: 'dtree', title: '决策树', desc: '直观的树形决策模型', topics: ['信息增益','基尼系数','剪枝'], status: 'in-progress' },
      { id: 'svm', title: 'SVM', desc: '强大的分类器', topics: ['核函数','间隔最大化','软间隔'], status: 'locked' },
      { id: 'kmeans', title: 'K-Means 聚类', desc: '无监督学习入门', topics: ['距离度量','簇心更新','肘部法则'], status: 'locked' },
      { id: 'pca', title: 'PCA 降维', desc: '数据降维与特征提取', topics: ['协方差矩阵','特征值分解','方差解释'], status: 'locked' },
      { id: 'cnn', title: 'CNN 卷积网络', desc: '深度学习与图像识别', topics: ['卷积层','池化层','ResNet'], status: 'locked' },
      { id: 'transformer', title: 'Transformer', desc: '大模型时代的基石', topics: ['自注意力','位置编码','BERT/GPT'], status: 'locked' },
    ],
    quizzes: [
      { topic: '线性回归', question: '线性回归最常用的损失函数是什么？', options: ['交叉熵损失','均方误差 (MSE)','Hinge 损失','KL 散度'], answer: 1, explain: '均方误差 (MSE) 是线性回归最常用的损失函数，衡量预测值与真实值的平均偏差。' },
      { topic: '逻辑回归', question: '逻辑回归主要用于什么类型的任务？', options: ['回归预测','分类任务','聚类分析','降维'], answer: 1, explain: '虽然名字里有「回归」，但逻辑回归是经典的分类算法，通过 Sigmoid 函数输出概率。' },
      { topic: '决策树', question: '决策树中，信息增益衡量的是什么？', options: ['分类准确率','划分后不确定性的减少量','树的深度','叶节点数量'], answer: 1, explain: '信息增益衡量的是按某特征划分后，数据集不确定性的减少量（熵的减少）。' },
      { topic: 'SVM', question: 'SVM 的核心思想是什么？', options: ['最小化训练误差','找到最大间隔超平面','构建决策树','降维映射'], answer: 1, explain: 'SVM 的核心是找到使两类样本间隔最大的分类超平面，提高泛化能力。' },
      { topic: 'K-Means', question: 'K-Means 算法需要预先指定什么参数？', options: ['学习率','簇的数量 K','树的深度','正则化系数'], answer: 1, explain: 'K-Means 需要预先指定簇的数量 K，这也是该算法的一个局限。' },
    ]
  },
  '中国历史': {
    nodes: [
      { id: 'zh', label: '中国历史', type: 'center', desc: '中华文明五千年的历史脉络', status: 'in-progress', related: ['古代史','近代史','现代史'] },
      { id: 'ancient', label: '古代史', type: 'l1', desc: '从远古到清朝灭亡的漫长历史', status: 'in-progress', related: ['秦汉','唐宋','明清'] },
      { id: 'modern', label: '近代史', type: 'l1', desc: '鸦片战争到新中国成立', status: 'not-started', related: ['鸦片战争','辛亥革命','五四运动'] },
      { id: 'contemp', label: '现代史', type: 'l1', desc: '新中国成立至今的发展历程', status: 'not-started', related: ['改革开放','现代化建设'] },
      { id: 'culture', label: '文化史', type: 'l1', desc: '思想、文学、艺术的发展脉络', status: 'not-started', related: ['儒家','道家','诗词'] },
      { id: 'qinhan', label: '秦汉', type: 'l2', desc: '大一统帝国的建立与巩固', status: 'completed', related: ['古代史','秦始皇'] },
      { id: 'tangsong', label: '唐宋', type: 'l2', desc: '中华文明的鼎盛时期', status: 'in-progress', related: ['古代史','诗词'] },
      { id: 'mingqing', label: '明清', type: 'l2', desc: '封建社会的晚期', status: 'not-started', related: ['古代史','闭关锁国'] },
      { id: 'yapian', label: '鸦片战争', type: 'l2', desc: '中国近代史的开端', status: 'not-started', related: ['近代史','不平等条约'] },
      { id: 'xinhai', label: '辛亥革命', type: 'l2', desc: '推翻封建帝制', status: 'not-started', related: ['近代史','孙中山'] },
      { id: 'wusi', label: '五四运动', type: 'l2', desc: '新民主主义革命的开端', status: 'not-started', related: ['近代史','新文化运动'] },
      { id: 'gaige', label: '改革开放', type: 'l2', desc: '1978年以来的经济转型', status: 'not-started', related: ['现代史','经济特区'] },
      { id: 'rujia', label: '儒家', type: 'l2', desc: '以仁义礼智信为核心的思想体系', status: 'completed', related: ['文化史','孔子'] },
      { id: 'daojia', label: '道家', type: 'l2', desc: '以道法自然为核心的哲学流派', status: 'not-started', related: ['文化史','老子'] },
    ],
    edges: [
      { from: 'zh', to: 'ancient' }, { from: 'zh', to: 'modern' }, { from: 'zh', to: 'contemp' }, { from: 'zh', to: 'culture' },
      { from: 'ancient', to: 'qinhan' }, { from: 'ancient', to: 'tangsong' }, { from: 'ancient', to: 'mingqing' },
      { from: 'modern', to: 'yapian' }, { from: 'modern', to: 'xinhai' }, { from: 'modern', to: 'wusi' },
      { from: 'contemp', to: 'gaige' },
      { from: 'culture', to: 'rujia' }, { from: 'culture', to: 'daojia' },
      { from: 'tangsong', to: 'rujia' }, { from: 'mingqing', to: 'yapian' },
    ],
    path: [
      { id: 'qinhan', title: '秦汉时期', desc: '大一统帝国的建立', topics: ['秦始皇统一','汉武帝','丝绸之路'], status: 'completed' },
      { id: 'rujia', title: '儒家思想', desc: '中华文化的核心', topics: ['孔孟之道','科举制','程朱理学'], status: 'completed' },
      { id: 'tangsong', title: '唐宋盛世', desc: '中华文明的巅峰', topics: ['贞观之治','唐诗宋词','四大发明'], status: 'in-progress' },
      { id: 'mingqing', title: '明清时期', desc: '封建社会的衰落', topics: ['郑和下西洋','闭关锁国','康乾盛世'], status: 'locked' },
      { id: 'yapian', title: '鸦片战争', desc: '近代史的开端', topics: ['南京条约','半殖民地化','洋务运动'], status: 'locked' },
      { id: 'xinhai', title: '辛亥革命', desc: '帝制的终结', topics: ['孙中山','三民主义','民国建立'], status: 'locked' },
    ],
    quizzes: [
      { topic: '秦汉', question: '秦始皇统一六国是在哪一年？', options: ['公元前230年','公元前221年','公元前210年','公元前206年'], answer: 1, explain: '公元前221年，秦始皇灭齐，完成统一六国大业，建立中国第一个大一统王朝。' },
      { topic: '儒家', question: '儒家核心思想「仁」是谁提出的？', options: ['孟子','荀子','孔子','董仲舒'], answer: 2, explain: '「仁」是孔子思想的核心，强调爱人、克己复礼。' },
      { topic: '唐宋', question: '「贞观之治」是哪位皇帝在位时期？', options: ['唐高祖','唐太宗','唐玄宗','宋太祖'], answer: 1, explain: '贞观之治是唐太宗李世民在位期间（627-649年）的盛世局面。' },
    ]
  },
  'Python编程': {
    nodes: [
      { id: 'py', label: 'Python编程', type: 'center', desc: '简洁优雅的通用编程语言', status: 'in-progress', related: ['基础语法','数据结构','面向对象','标准库'] },
      { id: 'syntax', label: '基础语法', type: 'l1', desc: '变量、运算符、控制流等语言基本构成', status: 'completed', related: ['变量与类型','条件语句','循环'] },
      { id: 'datastruct', label: '数据结构', type: 'l1', desc: '列表、元组、字典、集合等内置容器类型', status: 'in-progress', related: ['列表推导','字典操作','集合运算'] },
      { id: 'func', label: '函数与模块', type: 'l1', desc: '函数定义、参数传递、模块化编程', status: 'not-started', related: ['lambda','装饰器','包管理'] },
      { id: 'oop', label: '面向对象', type: 'l1', desc: '类、继承、多态、封装等OOP核心概念', status: 'not-started', related: ['类定义','继承','魔术方法'] },
      { id: 'stdlib', label: '标准库', type: 'l1', desc: 'os、sys、json、re等常用标准库', status: 'not-started', related: ['文件IO','正则表达式','日期处理'] },
      { id: 'var', label: '变量与类型', type: 'l2', desc: '动态类型系统，int/float/str/bool等基本类型', status: 'completed', related: ['基础语法','类型转换'] },
      { id: 'control', label: '控制流', type: 'l2', desc: 'if/elif/else条件判断与for/while循环', status: 'completed', related: ['基础语法','迭代器'] },
      { id: 'listcomp', label: '列表推导', type: 'l2', desc: 'Pythonic的简洁语法，一行生成列表', status: 'in-progress', related: ['数据结构','生成器'] },
      { id: 'dictop', label: '字典操作', type: 'l2', desc: '键值对容器的高级用法', status: 'not-started', related: ['数据结构','JSON'] },
      { id: 'lambda', label: 'Lambda', type: 'l2', desc: '匿名函数与函数式编程工具', status: 'not-started', related: ['函数与模块','高阶函数'] },
      { id: 'decorator', label: '装饰器', type: 'l2', desc: '不修改函数代码即可增强其行为的语法糖', status: 'not-started', related: ['函数与模块','闭包'] },
      { id: 'classdef', label: '类定义', type: 'l2', desc: 'class关键字、__init__、实例方法与类方法', status: 'not-started', related: ['面向对象','继承'] },
      { id: 'inherit', label: '继承与多态', type: 'l2', desc: '单继承、多继承、MRO、方法重写', status: 'not-started', related: ['面向对象','抽象类'] },
      { id: 'fileio', label: '文件IO', type: 'l2', desc: 'open/read/write/with语句与文件路径处理', status: 'not-started', related: ['标准库','上下文管理器'] },
      { id: 'regex', label: '正则表达式', type: 'l2', desc: 're模块，模式匹配与文本提取', status: 'not-started', related: ['标准库','字符串处理'] },
      { id: 'exception', label: '异常处理', type: 'l2', desc: 'try/except/finally与自定义异常类', status: 'not-started', related: ['基础语法','调试'] },
    ],
    edges: [
      { from: 'py', to: 'syntax' }, { from: 'py', to: 'datastruct' }, { from: 'py', to: 'func' }, { from: 'py', to: 'oop' }, { from: 'py', to: 'stdlib' },
      { from: 'syntax', to: 'var' }, { from: 'syntax', to: 'control' }, { from: 'syntax', to: 'exception' },
      { from: 'datastruct', to: 'listcomp' }, { from: 'datastruct', to: 'dictop' },
      { from: 'func', to: 'lambda' }, { from: 'func', to: 'decorator' },
      { from: 'oop', to: 'classdef' }, { from: 'oop', to: 'inherit' },
      { from: 'stdlib', to: 'fileio' }, { from: 'stdlib', to: 'regex' },
      { from: 'listcomp', to: 'lambda' }, { from: 'classdef', to: 'decorator' }, { from: 'fileio', to: 'exception' },
    ],
    path: [
      { id: 'var', title: '变量与类型', desc: 'Python动态类型系统入门', topics: ['基本类型','类型转换','字符串格式化'], status: 'completed' },
      { id: 'control', title: '控制流', desc: '条件判断与循环', topics: ['if/elif/else','for循环','while循环'], status: 'completed' },
      { id: 'listcomp', title: '列表推导', desc: 'Pythonic的核心语法', topics: ['列表推导','字典推导','生成器表达式'], status: 'in-progress' },
      { id: 'lambda', title: 'Lambda与函数式', desc: '匿名函数与高阶函数', topics: ['lambda','map/filter','闭包'], status: 'locked' },
      { id: 'classdef', title: '类定义', desc: '面向对象编程入门', topics: ['__init__','实例方法','属性'], status: 'locked' },
      { id: 'inherit', title: '继承与多态', desc: 'OOP进阶', topics: ['单继承','MRO','抽象基类'], status: 'locked' },
      { id: 'decorator', title: '装饰器', desc: 'Python高级语法', topics: ['函数装饰器','类装饰器','functools.wraps'], status: 'locked' },
      { id: 'fileio', title: '文件IO', desc: '文件读写与路径处理', topics: ['with语句','pathlib','CSV/JSON'], status: 'locked' },
    ],
    quizzes: [
      { topic: '变量与类型', question: 'Python中以下哪种类型是不可变的？', options: ['list','dict','tuple','set'], answer: 2, explain: 'tuple（元组）是不可变类型，创建后不能修改其元素。list、dict、set都是可变的。' },
      { topic: '列表推导', question: '[x**2 for x in range(5) if x % 2 == 0] 的结果是？', options: ['[0, 4, 16]','[0, 1, 4, 9, 16]','[0, 2, 4]','[1, 9]'], answer: 0, explain: 'range(5)中偶数为0,2,4，平方后为0,4,16。' },
      { topic: '装饰器', question: '装饰器@decorator等价于以下哪种写法？', options: ['func = decorator.func','func = decorator(func)','func.decorator()','func.__decorator__ = decorator'], answer: 1, explain: '@decorator是语法糖，等价于func = decorator(func)，将原函数传入装饰器并替换。' },
      { topic: '异常处理', question: 'try/except中finally块的特点是什么？', options: ['只在异常时执行','只在无异常时执行','无论是否异常都会执行','可以替代except'], answer: 2, explain: 'finally块无论是否发生异常都会执行，常用于资源清理。' },
      { topic: '面向对象', question: 'Python中__init__方法的作用是什么？', options: ['销毁对象','初始化实例属性','定义类属性','实现运算符重载'], answer: 1, explain: '__init__是构造方法，在创建实例时自动调用，用于初始化实例属性。' },
    ]
  },
  '前端开发': {
    nodes: [
      { id: 'fe', label: '前端开发', type: 'center', desc: '构建用户界面与交互体验的Web技术体系', status: 'in-progress', related: ['HTML/CSS','JavaScript','框架','工程化'] },
      { id: 'htmlcss', label: 'HTML/CSS', type: 'l1', desc: '网页结构与样式的基础技术', status: 'completed', related: ['语义化','Flexbox','Grid'] },
      { id: 'js', label: 'JavaScript', type: 'l1', desc: '前端核心编程语言，实现动态交互', status: 'in-progress', related: ['ES6+','DOM','异步'] },
      { id: 'framework', label: '前端框架', type: 'l1', desc: 'React/Vue/Angular等组件化开发框架', status: 'not-started', related: ['React','Vue','状态管理'] },
      { id: 'engineering', label: '前端工程化', type: 'l1', desc: '构建工具、模块化、CI/CD等工程实践', status: 'not-started', related: ['Webpack','Vite','TypeScript'] },
      { id: 'responsive', label: '响应式设计', type: 'l1', desc: '适配多种屏幕尺寸的布局策略', status: 'not-started', related: ['媒体查询','移动优先','弹性布局'] },
      { id: 'semantic', label: '语义化', type: 'l2', desc: '使用有意义的HTML标签提升可访问性与SEO', status: 'completed', related: ['HTML/CSS','无障碍'] },
      { id: 'flexbox', label: 'Flexbox', type: 'l2', desc: '一维弹性布局模型', status: 'completed', related: ['HTML/CSS','Grid'] },
      { id: 'es6', label: 'ES6+', type: 'l2', desc: '解构、箭头函数、Promise等现代语法', status: 'in-progress', related: ['JavaScript','模块化'] },
      { id: 'dom', label: 'DOM操作', type: 'l2', desc: '文档对象模型，JavaScript操作页面元素的核心接口', status: 'in-progress', related: ['JavaScript','事件系统'] },
      { id: 'async', label: '异步编程', type: 'l2', desc: 'Promise、async/await、事件循环机制', status: 'not-started', related: ['JavaScript','ES6+'] },
      { id: 'react', label: 'React', type: 'l2', desc: '声明式UI库，组件化与虚拟DOM', status: 'not-started', related: ['前端框架','Hooks'] },
      { id: 'vue', label: 'Vue', type: 'l2', desc: '渐进式框架，响应式数据绑定与组合式API', status: 'not-started', related: ['前端框架','模板语法'] },
      { id: 'state', label: '状态管理', type: 'l2', desc: 'Redux/Vuex/Pinia等全局状态管理方案', status: 'not-started', related: ['前端框架','数据流'] },
      { id: 'vite', label: 'Vite', type: 'l2', desc: '新一代前端构建工具', status: 'not-started', related: ['前端工程化','HMR'] },
      { id: 'typescript', label: 'TypeScript', type: 'l2', desc: 'JavaScript的类型超集，提升代码健壮性', status: 'not-started', related: ['前端工程化','类型系统'] },
      { id: 'perf', label: '性能优化', type: 'l2', desc: '懒加载、代码分割、缓存策略等优化手段', status: 'not-started', related: ['前端工程化','Core Web Vitals'] },
    ],
    edges: [
      { from: 'fe', to: 'htmlcss' }, { from: 'fe', to: 'js' }, { from: 'fe', to: 'framework' }, { from: 'fe', to: 'engineering' }, { from: 'fe', to: 'responsive' },
      { from: 'htmlcss', to: 'semantic' }, { from: 'htmlcss', to: 'flexbox' },
      { from: 'js', to: 'es6' }, { from: 'js', to: 'dom' }, { from: 'js', to: 'async' },
      { from: 'framework', to: 'react' }, { from: 'framework', to: 'vue' }, { from: 'framework', to: 'state' },
      { from: 'engineering', to: 'vite' }, { from: 'engineering', to: 'typescript' }, { from: 'engineering', to: 'perf' },
      { from: 'es6', to: 'async' }, { from: 'dom', to: 'react' }, { from: 'react', to: 'state' }, { from: 'vue', to: 'state' }, { from: 'vite', to: 'perf' },
    ],
    path: [
      { id: 'semantic', title: 'HTML语义化', desc: '前端开发的基础', topics: ['语义标签','表单','无障碍'], status: 'completed' },
      { id: 'flexbox', title: 'Flexbox布局', desc: 'CSS弹性布局', topics: ['主轴对齐','换行','flex-grow/shrink'], status: 'completed' },
      { id: 'es6', title: 'ES6+语法', desc: '现代JavaScript', topics: ['箭头函数','解构赋值','模板字符串'], status: 'in-progress' },
      { id: 'async', title: '异步编程', desc: 'Promise与async/await', topics: ['Promise链','事件循环','错误处理'], status: 'locked' },
      { id: 'react', title: 'React入门', desc: '组件化开发', topics: ['JSX','Hooks','状态管理'], status: 'locked' },
      { id: 'typescript', title: 'TypeScript', desc: '类型安全的JavaScript', topics: ['接口','泛型','类型推断'], status: 'locked' },
    ],
    quizzes: [
      { topic: '语义化', question: 'HTML5中哪个标签用于表示导航区域？', options: ['<div>','<nav>','<section>','<aside>'], answer: 1, explain: '<nav>标签专门用于表示页面导航区域，是HTML5新增的语义化标签。' },
      { topic: 'Flexbox', question: 'Flexbox中justify-content控制的是哪个轴的对齐？', options: ['交叉轴','主轴','两个轴','都不控制'], answer: 1, explain: 'justify-content控制主轴方向的对齐方式，align-items控制交叉轴方向。' },
      { topic: 'ES6+', question: 'const声明的变量意味着什么？', options: ['值不可变','绑定不可变','类型不可变','作用域不可变'], answer: 1, explain: 'const保证变量绑定不可变（不能重新赋值），但对象属性仍可修改。' },
    ]
  },
  '产品经理': {
    nodes: [
      { id: 'pm', label: '产品经理', type: 'center', desc: '负责产品规划、设计和推进落地的角色', status: 'in-progress', related: ['需求分析','用户研究','数据驱动'] },
      { id: 'req', label: '需求分析', type: 'l1', desc: '识别、收集和优先级排序用户需求', status: 'in-progress', related: ['用户画像','PRD','优先级'] },
      { id: 'user', label: '用户研究', type: 'l1', desc: '深入了解用户行为、痛点和期望', status: 'not-started', related: ['用户访谈','可用性测试','用户画像'] },
      { id: 'data', label: '数据驱动', type: 'l1', desc: '用数据指导产品决策和优化', status: 'not-started', related: ['A/B测试','漏斗分析','指标体系'] },
      { id: 'proj', label: '项目管理', type: 'l1', desc: '协调团队推进产品落地', status: 'not-started', related: ['敏捷开发','Scrum','迭代'] },
      { id: 'persona', label: '用户画像', type: 'l2', desc: '基于数据的典型用户模型', status: 'completed', related: ['需求分析','用户研究'] },
      { id: 'prd', label: 'PRD', type: 'l2', desc: '产品需求文档，定义产品做什么', status: 'in-progress', related: ['需求分析','功能设计'] },
      { id: 'abtest', label: 'A/B测试', type: 'l2', desc: '对照实验验证产品假设', status: 'not-started', related: ['数据驱动','假设检验'] },
      { id: 'funnel', label: '漏斗分析', type: 'l2', desc: '分析用户转化路径中的流失点', status: 'not-started', related: ['数据驱动','转化率'] },
      { id: 'agile', label: '敏捷开发', type: 'l2', desc: '快速迭代、持续交付的开发方法', status: 'not-started', related: ['项目管理','Scrum'] },
      { id: 'compete', label: '竞品分析', type: 'l2', desc: '分析竞争对手产品的优劣势', status: 'not-started', related: ['需求分析','市场定位'] },
      { id: 'priority', label: '优先级', type: 'l2', desc: 'RICE/ICE等模型排列需求优先级', status: 'completed', related: ['需求分析','资源分配'] },
    ],
    edges: [
      { from: 'pm', to: 'req' }, { from: 'pm', to: 'user' }, { from: 'pm', to: 'data' }, { from: 'pm', to: 'proj' },
      { from: 'req', to: 'persona' }, { from: 'req', to: 'prd' }, { from: 'req', to: 'priority' }, { from: 'req', to: 'compete' },
      { from: 'user', to: 'persona' },
      { from: 'data', to: 'abtest' }, { from: 'data', to: 'funnel' },
      { from: 'proj', to: 'agile' },
      { from: 'persona', to: 'funnel' },
    ],
    path: [
      { id: 'persona', title: '用户画像', desc: '理解你的用户是谁', topics: ['人口统计','行为特征','痛点分析'], status: 'completed' },
      { id: 'priority', title: '需求优先级', desc: '决定先做什么后做什么', topics: ['RICE模型','MoSCoW','Kano模型'], status: 'completed' },
      { id: 'prd', title: 'PRD需求文档', desc: '把想法变成可执行的方案', topics: ['功能清单','交互流程','验收标准'], status: 'in-progress' },
      { id: 'compete', title: '竞品分析', desc: '知己知彼', topics: ['SWOT分析','差异化','市场定位'], status: 'locked' },
      { id: 'abtest', title: 'A/B测试', desc: '用数据验证假设', topics: ['假设设计','样本量','统计显著性'], status: 'locked' },
      { id: 'agile', title: '敏捷开发', desc: '快速迭代交付', topics: ['Sprint','站会','回顾'], status: 'locked' },
    ],
    quizzes: [
      { topic: '用户画像', question: '用户画像的核心目的是什么？', options: ['美化产品界面','精准理解目标用户','增加用户数量','降低开发成本'], answer: 1, explain: '用户画像的核心是精准理解目标用户的需求、行为和痛点，指导产品决策。' },
      { topic: '优先级', question: 'RICE模型中的R代表什么？', options: ['Revenue（收入）','Reach（覆盖范围）','Risk（风险）','Retention（留存）'], answer: 1, explain: 'RICE = Reach × Impact × Confidence / Effort，R代表Reach（覆盖范围）。' },
      { topic: 'PRD', question: 'PRD中最重要的部分是什么？', options: ['排版美观','功能清单与验收标准','团队合影','技术实现细节'], answer: 1, explain: 'PRD的核心是清晰定义功能需求和验收标准，确保团队对「做什么」达成共识。' },
    ]
  },
}

// 获取主题数据
export function getTopicData(topic: string): TopicData | null {
  if (topicDB[topic]) {
    return topicDB[topic]
  }
  return null
}

// 关键词主题生成（非预设主题的本地生成）
export function generateKeywordTopic(keyword: string): TopicData {
  const l1Items: L1Item[] = [
    { label: '基础概念', desc: `${keyword}的核心基础概念与术语`, related: ['定义', '分类', '特征'] },
    { label: '核心理论', desc: `${keyword}的主要理论框架与模型`, related: ['原理', '模型', '框架'] },
    { label: '实践应用', desc: `${keyword}在实际场景中的应用方法`, related: ['案例', '工具', '方法'] },
    { label: '进阶拓展', desc: `${keyword}的高级主题与前沿发展`, related: ['趋势', '研究', '创新'] },
  ]

  const l2Items: L2Item[] = [
    { label: '定义与分类', desc: `${keyword}的基本定义和主要分类体系`, related: ['基础概念'] },
    { label: '关键特征', desc: `${keyword}区别于其他领域的核心特征`, related: ['基础概念'] },
    { label: '基本原理', desc: `${keyword}运作的基本原理和规律`, related: ['核心理论'] },
    { label: '主要模型', desc: `${keyword}领域常用的分析模型和框架`, related: ['核心理论', '基本原理'] },
    { label: '典型应用', desc: `${keyword}在现实中的典型应用场景`, related: ['实践应用'] },
    { label: '常用工具', desc: `学习和应用${keyword}的常用工具与资源`, related: ['实践应用'] },
    { label: '最新趋势', desc: `${keyword}领域的最新发展趋势`, related: ['进阶拓展'] },
    { label: '研究方向', desc: `${keyword}的前沿研究方向与热点`, related: ['进阶拓展', '最新趋势'] },
  ]

  const nodes: GraphNode[] = []
  const edges: GraphEdge[] = []

  // 中心节点
  nodes.push({
    id: 'root', label: keyword, type: 'center',
    desc: `关于${keyword}的完整知识体系`, status: 'in-progress',
    related: l1Items.map(item => item.label)
  })

  // L1节点
  for (let i = 0; i < l1Items.length; i++) {
    const item = l1Items[i]
    const id = 'l1_' + (i + 1)
    nodes.push({
      id: id, label: item.label, type: 'l1',
      desc: item.desc, status: 'not-started', related: item.related
    })
    edges.push({ from: 'root', to: id })
  }

  // L2节点
  for (let i = 0; i < l2Items.length; i++) {
    const item = l2Items[i]
    const id = 'l2_' + (i + 1)
    nodes.push({
      id: id, label: item.label, type: 'l2',
      desc: item.desc, status: 'not-started', related: item.related
    })
    // 连接到对应的L1节点
    if (i < 2) {
      edges.push({ from: 'l1_1', to: id })
    } else if (i < 4) {
      edges.push({ from: 'l1_2', to: id })
    } else if (i < 6) {
      edges.push({ from: 'l1_3', to: id })
    } else {
      edges.push({ from: 'l1_4', to: id })
    }
  }

  // L2之间的关联
  edges.push({ from: 'l2_3', to: 'l2_4' })
  edges.push({ from: 'l2_7', to: 'l2_8' })

  const path: PathStep[] = [
    { id: 'l2_1', title: '定义与分类', desc: `理解${keyword}的基本概念`, topics: ['基本定义', '分类体系', '核心术语'], status: 'in-progress' },
    { id: 'l2_2', title: '关键特征', desc: `掌握${keyword}的核心特征`, topics: ['核心属性', '对比分析', '独特价值'], status: 'not-started' },
    { id: 'l2_3', title: '基本原理', desc: `深入${keyword}的原理`, topics: ['运作机制', '核心规律', '理论支撑'], status: 'locked' },
    { id: 'l2_4', title: '主要模型', desc: `学习${keyword}的分析模型`, topics: ['经典模型', '应用场景', '优缺点'], status: 'locked' },
    { id: 'l2_5', title: '典型应用', desc: `${keyword}的实践应用`, topics: ['应用案例', '最佳实践', '常见问题'], status: 'locked' },
    { id: 'l2_6', title: '常用工具', desc: `掌握${keyword}相关工具`, topics: ['工具选择', '使用技巧', '效率提升'], status: 'locked' },
    { id: 'l2_7', title: '最新趋势', desc: `了解${keyword}的发展趋势`, topics: ['行业动态', '技术演进', '未来方向'], status: 'locked' },
    { id: 'l2_8', title: '研究方向', desc: `探索${keyword}的前沿`, topics: ['研究热点', '学术前沿', '创新机会'], status: 'locked' },
  ]

  const quizzes: QuizItem[] = [
    {
      topic: '定义与分类',
      question: `关于${keyword}，以下哪个说法最准确？`,
      options: [`${keyword}是一个系统性的知识领域`, `${keyword}只是一种工具`, `${keyword}不需要学习基础`, `${keyword}与其它领域无关`],
      answer: 0,
      explain: `${keyword}作为一个知识领域，具有系统性的概念体系和分类框架。`
    },
    {
      topic: '基本原理',
      question: `学习${keyword}的基本原理，最重要的是理解什么？`,
      options: ['记忆所有术语', '理解核心运作机制', '背诵公式', '模仿他人做法'],
      answer: 1,
      explain: `理解核心运作机制是掌握${keyword}基本原理的关键，而非死记硬背。`
    },
    {
      topic: '实践应用',
      question: `将${keyword}应用到实践中，最有效的方法是什么？`,
      options: ['只看理论不实践', '通过实际案例和项目练习', '等待完美时机再开始', '只关注最新趋势'],
      answer: 1,
      explain: '通过实际案例和项目练习是将理论知识转化为实践能力的最有效方法。'
    },
  ]

  return { nodes, edges, path, quizzes }
}

// 获取或生成主题数据
export function getOrGenerateTopicData(topic: string): TopicData {
  const existing = topicDB[topic]
  if (existing) {
    return existing
  }
  return generateKeywordTopic(topic)
}
