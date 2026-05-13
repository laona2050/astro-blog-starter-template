---
title: '[tech] Horizon 每日速递 - 2026-05-13'
description: 'Horizon 每日速递'
pubDate: 2026-05-13
category: '国际时政'
tags: ['AI', 'Horizon', 'tech', '每日资讯']
---

# Horizon 每日速递 - 2026-05-13

> From 12 items, 6 important content pieces were selected

---

1. [CERT 为 dnsmasq 发布六个严重安全漏洞公告](#item-1) ⭐️ 8.0/10
2. [Cactus 开源 Needle：2600 万参数模型实现高效设备端函数调用](#item-2) ⭐️ 7.0/10
3. [DuckDB Quack 协议实现客户端-服务器架构](#item-3) ⭐️ 7.0/10
4. [Obsidian 推出自动化插件审核系统](#item-4) ⭐️ 7.0/10
5. [Bambu Lab 因涉嫌滥用开源协议引发社区抗议](#item-5) ⭐️ 7.0/10
6. [渲染天空、日落和行星](#item-6) ⭐️ 6.0/10

---

## [CERT 为 dnsmasq 发布六个严重安全漏洞公告](https://lists.thekelleys.org.uk/pipermail/dnsmasq-discuss/2026q2/018471.html) ⭐️ 8.0/10

美国计算机应急响应小组（CERT）协调中心正在发布六个针对 dnsmasq 严重安全漏洞的 CVE 编号。dnsmasq 是一款广泛使用的 DNS 转发器和 DHCP 服务器。这些漏洞包括堆越界写入、恶意 DNS 响应导致的无限循环，以及通过恶意 DHCP 请求触发的缓冲区溢出。 dnsmasq 部署在数百万路由器、物联网设备和嵌入式系统中。同时发布多个严重 CVE 表明这个广泛部署的代码库存在系统性安全问题，影响消费者和企业级基础设施。社区正在讨论这是否标志着在关键 DNS 基础设施中采用内存安全语言的转折点。 这些漏洞允许能够发送 DNS 查询或响应的远程攻击者执行大范围堆越界写入，并触发无限循环导致 dnsmasq 停止响应查询。恶意 DHCP 请求也可触发缓冲区溢出。社区成员指出 OpenWRT 正在积极修复，而 Debian 稳定版仍使用过时版本的 dnsmasq。

hackernews · chizhik-pyzhik · May 12, 18:12 · [社区讨论](https://news.ycombinator.com/item?id=48112042)

**背景**: dnsmasq 是一款为小型网络设计的轻量级 DNS 转发器，常见于路由器、防火墙和物联网设备（包括 OpenWRT）。由于采用 C 语言编写，它缺乏现代编程语言提供的内存保护机制。最新行业数据显示，主要平台中 60-70%的漏洞源于内存安全问题，促使 CISA 和 NSA 等机构建议将关键基础设施组件迁移至 Rust 或 Go 等内存安全语言。

<details><summary>参考链接</summary>
<ul>
<li><a href="https://en.wikipedia.org/wiki/Dnsmasq">dnsmasq - Wikipedia</a></li>
<li><a href="https://www.memorysafety.org/docs/memory-safety/">What is memory safety and why does it matter? - Prossimo Memory Safe Languages: Reducing Vulnerabilities in ... - CISA White House urges developers to avoid C and C++, use 'memory ... How to secure memory-safe vs. manually managed languages Which Programming Languages Are Truly Memory Safe?</a></li>
<li><a href="https://media.defense.gov/2025/Jun/23/2003742198/-1/-1/0/CSI_MEMORY_SAFE_LANGUAGES_REDUCING_VULNERABILITIES_IN_MODERN_SOFTWARE_DEVELOPMENT.PDF">Memory Safe Languages: Reducing Vulnerabilities in Modern ...</a></li>

</ul>
</details>

**社区讨论**: 社区成员正在讨论各发行版是否应该升级到新版本而非应用回溯补丁，有人批评 Debian 维护过时软件包的做法。多人呼吁用 Rust 或 Go 等内存安全语言重写 dnsmasq，认为反复出现的漏洞模式使传统 C 代码在关键基础设施中难以为继。MaraDNS 维护者借此机会推广其替代方案，而其他人则在等待 OpenWRT 的官方安全更新。

**标签**: `#security`, `#dnsmasq`, `#memory-safety`, `#CVE`, `#DNS`, `#Rust`

---

## [Cactus 开源 Needle：2600 万参数模型实现高效设备端函数调用](https://github.com/cactus-compute/needle) ⭐️ 7.0/10

Cactus 发布了 Needle，这是一款 2600 万参数的函数调用模型，采用纯注意力机制的"Simple Attention Network"架构，完全不使用 MLP/FFN 层，在消费级硬件上实现了 6000 tok/s 的预填充速度和 1200 tok/s 的解码速度。 这挑战了函数调用必须依赖大模型的假设，证明了当使用交叉注意力进行检索-组装而非推理时，2600 万参数就足够用了，使得在平价手机、手表和 AR 眼镜上运行复杂的智能体体验成为可能。 该模型在 200B tokens 上进行了预训练（16 块 TPU v6e，耗时 27 小时），并在由 Gemini 生成的 20 亿 token 合成函数调用数据上进行了后训练，涵盖 15 个工具类别。在单次函数调用基准测试中，其性能优于 FunctionGemma-270M、Qwen-0.6B、Granite-350M 和 LFM2.5-350M。

hackernews · HenryNdubuaku · May 12, 18:03 · [社区讨论](https://news.ycombinator.com/item?id=48111896)

**背景**: 函数调用（工具调用）是 AI 模型选择和调用外部工具的机制——将用户查询与工具名称匹配，提取参数值，输出结构化 JSON。传统大型语言模型依赖 FFN（前馈网络）层进行知识存储和推理，但研究表明，当输入中可用的外部结构化知识（如 RAG 或工具定义）时，FFN 的记忆功能变得冗余，可以移除而不会导致性能损失。

<details><summary>参考链接</summary>
<ul>
<li><a href="https://arxiv.org/html/2410.13732v1">Reducing the Transformer Architecture to a Minimum</a></li>

</ul>
</details>

**社区讨论**: HN 讨论区引发了实质性讨论：用户质疑该模型在复杂查询上的区分能力，并建议将其应用于 CLI 场景，用自然语言参数替代传统语法。值得注意的是，评论者 kgeist 指出，有独立研究的学生也验证了移除 MLP 的发现——Qwen 移除 MLP 后仍能执行输入转换任务，但会失去记忆知识。有人建议在低成本 VPS 上发布 playgrounds 的在线演示，以降低测试门槛。

**标签**: `#llm`, `#on-device-ai`, `#tool-calling`, `#model-optimization`, `#open-source`

---

## [DuckDB Quack 协议实现客户端-服务器架构](https://duckdb.org/2026/05/12/quack-remote-protocol) ⭐️ 7.0/10

DuckDB Labs 于 2026 年 5 月 12 日发布了"Quack"客户端-服务器协议，首次使 DuckDB 实例能够通过网络通信，并支持多并发写入的客户端-服务器架构。 这一发布解决了 DuckDB 最大的历史性限制——水平扩展问题，为分布式部署、内部应用程序和共享分析基础设施开辟了新的可能性，而这些之前都需要复杂的变通方案。 Quack 协议基于 HTTP 构建，在批量分析操作中比 PostgreSQL 快 32 倍。duckdb-quack 扩展允许 DuckDB 实例同时充当服务器和客户端，并完整支持服务器端的多并发写入。

hackernews · aduffy · May 12, 17:54 · [社区讨论](https://news.ycombinator.com/item?id=48111765)

**背景**: DuckDB 是一款流行的进程内分析型数据库，专为快速 OLAP 工作负载而设计，传统上作为嵌入式单节点数据库运行，没有原生网络能力。缺乏客户端-服务器架构一直是团队希望在 DuckDB 之上构建分布式或多用户应用程序时的已知限制。Quack 协议将 DuckDB 从纯嵌入式数据库转变为网络化服务，同时保持其分析性能优势。

<details><summary>参考链接</summary>
<ul>
<li><a href="https://motherduck.com/blog/first-variant/duckdb-client-server/">If It Quacks Like a Duck: DuckDB Gets a Client-Server Protocol</a></li>
<li><a href="https://byteiota.com/quack-protocol-duckdb-client-server-32x-faster/">Quack Protocol: DuckDB Client-Server 32x Faster | byteiota</a></li>
<li><a href="https://github.com/duckdb/duckdb-quack">GitHub - duckdb/duckdb-quack · GitHub</a></li>

</ul>
</details>

**社区讨论**: 社区反响总体积极，评论者们对内部应用程序框架、列式电子表格集成和家庭实验室设置等实际应用感到兴奋。一位开发者表示，这解决了其公司内部应用程序框架的"水平扩展"问题，而另一位开发者则提到为类似项目构建了自定义 HTTP 层。然而，随着项目持续扩展其用例，一些人仍对 DuckDB 的整体方向存在不确定性。

**标签**: `#duckdb`, `#database`, `#client-server`, `#distributed-systems`, `#open-source`

---

## [Obsidian 推出自动化插件审核系统](https://obsidian.md/blog/future-of-plugins/) ⭐️ 7.0/10

Obsidian 推出了全新的自动化插件审核系统和社区网站，以取代此前成为插件开发者瓶颈的手动审核流程，首席执行官亲自在社区中宣布了这一变化。 这一变化解决了一个重大的扩展问题——Obsidian 团队仅有七人，却面对数千名插件开发者，手动审核导致了开发者倦怠和漫长的提交等待，几乎不可能提交新插件。 新系统包含自动化安全检查，但社区成员提出了担忧：自动化审核无法可靠地检测恶意插件，他们认为唯一的可行解决方案是建立具有权限系统的适当沙箱机制，因为目前插件拥有完整的磁盘和网络访问权限。

hackernews · xz18r · May 12, 15:45 · [社区讨论](https://news.ycombinator.com/item?id=48109970)

**背景**: Obsidian 是一款流行的笔记应用，以 Markdown 文件格式本地存储笔记，支持由社区构建的广泛插件和主题生态系统。其开放的架构使其在高级用户和知识工作者中广受欢迎，他们希望自定义自己的笔记体验。

<details><summary>参考链接</summary>
<ul>
<li><a href="https://en.wikipedia.org/wiki/Obsidian_(software)">Obsidian (software) - Wikipedia</a></li>
<li><a href="https://obsidian.md/">Obsidian - Sharpen your thinking</a></li>

</ul>
</details>

**社区讨论**: 社区庆祝这一发布，认为它缓解了审核瓶颈问题，有评论者指出由于手动审核和 AI 生成的插件提交，提交新插件几乎是不可能的。然而，安全担忧主导了讨论——批评者认为自动化检查无法取代适当的沙箱机制，指出当前的插件模型授予完整的磁盘和网络访问权限，实际上是一种"点击即获远程代码执行"的安全模型。

**标签**: `#obsidian`, `#plugins`, `#developer-experience`, `#community-platform`, `#open-source-ecosystem`

---

## [Bambu Lab 因涉嫌滥用开源协议引发社区抗议](https://www.jeffgeerling.com/blog/2026/bambu-lab-abusing-open-source-social-contract/) ⭐️ 7.0/10

Bambu Lab 向一个 OrcaSlicer 开源分支项目的开发者发出停止侵权警告，指控其进行" impersonation attack"（冒充攻击）和逆向工程。开发者 Jarczak 在 GitHub 上声明，他的项目使用的是 Bambu Studio 的上游代码，并未进行任何逆向工程。Bambu Lab 声称该分支造成了服务器压力和不稳定，原因是其使用了伪装成官方客户端的 USER AGENT STRING。 这一争议凸显了依赖开源代码的公司与其开发者社区之间的持续紧张关系。如果 Bambu Lab 的激进法律策略成功，可能会为其他开源项目开创一个危险的先例，可能会抑制 3D 打印乃至更广泛领域的创新。结果可能会决定公司能在多大程度上对其认为的"不当使用"对社区贡献者进行严格执法。 有争议的分支项目使用的是 Bambu Studio 的上游代码，仅做了少量修改，但 Bambu Lab 声称其"向网络通信中注入了伪造的身份数据"。批评者认为 USER AGENT STRING 只是客户端提供的元数据，不是安全机制——Bambu Lab 本质上是在发现用户代理不能作为认证手段。社区成员指出，Bambu Lab 此前曾在类似的公众抗议后收回了对 LAN 模式功能的限制，表明社区压力可能是有效的。

hackernews · rubenbe · May 12, 14:54 · [社区讨论](https://news.ycombinator.com/item?id=48109224)

**背景**: 开源社交契约指的是一种隐性协议，开源项目根据 GPL 或 MIT 等许可证自由分享代码，同时期望公司会尊重这些许可证的字面规定和精神，并为社区做出回馈。Bambu Lab 的打印机运行在开源软件上，但该公司因创造了一个"封闭生态系统"而受到批评，限制了用户对设备的完全控制。基于开源构建商业产品的公司，有时会在社区成员创建绕过其专有服务或限制的工具时面临紧张局面。

<details><summary>参考链接</summary>
<ul>
<li><a href="https://www.jeffgeerling.com/blog/2026/bambu-lab-abusing-open-source-social-contract/">Bambu Lab is abusing the open source social contract</a></li>
<li><a href="https://news.slashdot.org/story/26/05/11/0235215/open-source-project-shuts-down-over-legal-threats-from-3d-printer-company-bambu-lab">Open Source Project Shuts Down Over Legal Threats from 3D Printer Company Bambu Lab - Slashdot</a></li>
<li><a href="https://1023jack.com/news/bambu-lab-is-abusing-the-open-source-social-contract/">Bambu Lab is abusing the open source social contract - 1023 Jack</a></li>

</ul>
</details>

**社区讨论**: 社区反应不一，但总体上对 Bambu Lab 持批评态度。评论者注意到，Bambu Lab 关于服务器不稳定的说辞实际上是在承认其基础设施无法应对自己产品的受欢迎程度。有些评论者将此与之前的 LAN 模式争议进行类比，认为公众压力此前曾迫使 Bambu Lab 改变做法。一场技术辩论也随之展开：客户端元数据（USER AGENT STRING）是否构成"冒充"，还是仅仅使用了 Bambu Lab 选择不加密的可用协议。

**标签**: `#open-source`, `#Bambu Lab`, `#3D printing`, `#licensing`, `#community`

---

## [渲染天空、日落和行星](https://blog.maximeheckel.com/posts/on-rendering-the-sky-sunsets-and-planets/) ⭐️ 6.0/10

Maxime Heckel 发布了一篇技术博客文章，解释如何使用大气散射算法（通过 WebGL 和 GLSL shader 实现）来渲染逼真的天空、日落和行星。 这篇教程让大气渲染的高级技术对 Web 开发者和图形程序员更加触手可及，使得在浏览器应用和游戏中实现逼真的天空模拟成为可能。 文章涵盖了瑞利散射（解释了白天天空为何是蓝色的）和米氏散射（影响了地平线附近的朦胧外观以及日落的金色色调）。一位社区评论正确指出，演示中应该显示直到太阳低于地平线 18 度时仍有暮光存在。

hackernews · ibobev · May 12, 13:26 · [社区讨论](https://news.ycombinator.com/item?id=48107997)

**背景**: 大气散射是导致天空中我们看到的颜色的物理现象。瑞利散射发生在光与比其波长小得多的粒子（如空气分子）相互作用时，将较短的蓝色波长散射得比红色更多，使白天的天空呈现蓝色。米氏散射发生在粒子与光的波长相当的情况下（如气溶胶和水滴），影响更大的角度，并产生地平线附近的朦胧效果。1993 年西冈等人发表的经典论文《考虑大气散射的地球显示》建立了许多至今仍在使用的基础技术。

<details><summary>参考链接</summary>
<ul>
<li><a href="https://en.wikipedia.org/wiki/Rayleigh_scattering">Rayleigh scattering</a></li>
<li><a href="https://en.wikipedia.org/wiki/Mie_scattering">Mie scattering</a></li>
<li><a href="https://www.gamedev.net/articles/programming/graphics/real-time-atmospheric-scattering-r2093/">Real-Time Atmospheric Scattering - Graphics and... - GameDev.net</a></li>

</ul>
</details>

**社区讨论**: 讨论强调了一个有价值的技术修正：演示错误地显示了太阳落山时天空立即变黑，而现实中暮光会持续到太阳低于地平线 18 度。社区成员还提到了相关工作，如 Sebastian Lague 的行星生成视频和奠基性的西冈 1993 年论文，并对现代浏览器运行此类渲染的出色能力表示赞叹。

**标签**: `#graphics-programming`, `#atmospheric-scattering`, `#webgl`, `#rayleigh-mie-scattering`, `#procedural-rendering`

---

