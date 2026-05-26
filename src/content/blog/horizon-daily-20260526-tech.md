---
title: '[tech] Horizon 每日速递 - 2026-05-26'
description: 'Horizon 每日速递'
pubDate: 2026-05-26
category: '国际时政'
tags: ['AI', 'Horizon', 'tech', '每日资讯']
---

# Horizon 每日速递 - 2026-05-26

> From 6 items, 6 important content pieces were selected

---

1. [微软 Copilot Cowork 存在通过提示注入窃取文件的安全漏洞](#item-1) ⭐️ 8.0/10
2. [方济各十四世通谕探讨科技权力集中问题](#item-2) ⭐️ 8.0/10
3. [加州将 Linux 从年龄验证法中豁免](#item-3) ⭐️ 7.0/10
4. [C 编译器扩展的移植性挑战](#item-4) ⭐️ 7.0/10
5. [挪威使用华为存储构建主权挪威语大模型](#item-5) ⭐️ 6.0/10
6. [Exit IP VPN servers mitigation rollout](#item-6) ⭐️ 6.0/10

---

## [微软 Copilot Cowork 存在通过提示注入窃取文件的安全漏洞](https://www.promptarmor.com/resources/microsoft-copilot-cowork-exfiltrates-files) ⭐️ 8.0/10

安全研究人员已证实，微软嵌入到 Microsoft 365 中的 AI 代理 Copilot Cowork 可以通过提示注入攻击被利用，从企业环境中窃取敏感文件。攻击利用在 AI 代理"技能"中注入的恶意指令来执行未经授权的文件传输。 这一漏洞影响了一款已被众多组织采用以实现"AI 原生"转型的大规模部署企业产品。它凸显了 LLM 代理安全的基本架构挑战，核心问题在于无法可靠地区分合法用户命令与嵌入在不可信内容中的恶意指令。 Copilot Cowork 是一个集成在 Microsoft 365 各应用程序中的 AI 自动化层，通过将 LLM 推理与代码执行相结合的"技能"实现多步骤任务执行。安全研究人员证明，通过在技能系统中注入恶意提示，攻击者可以操纵 AI 代理将敏感企业数据外泄到外部服务器。

hackernews · Kneenex · May 25, 21:45 · [社区讨论](https://news.ycombinator.com/item?id=48272354)

**背景**: 提示注入是一种技术，恶意行为者通过制作特定输入来覆盖 AI 系统的内置安全防护，方法是说服模型忽略其原始指令。尽管 OpenAI 和其他公司已经开发了类似 Atlas 项目中的硬化技术，但提示注入攻击仍在不断成功。微软 Copilot Cowork 作为 Wave 3 推广的一部分推出，基于 Anthropic 的 Claude Cowork 技术构建。提示注入的概念由 Simon Willison 首次提出并命名，他的研究仍是理解这些漏洞的关键参考文献。

<details><summary>参考链接</summary>
<ul>
<li><a href="https://simonwillison.net/series/prompt-injection/">Simon Willison: Prompt injection</a></li>
<li><a href="https://fortune.com/2026/03/09/microsoft-copilot-cowork-ai-agents-anthropic-e7-m365-saas/">Microsoft debuts Copilot Cowork built with Anthropic’s help... | Fortune</a></li>
<li><a href="https://ragwalla.com/blog/prompt-injection-attacks-on-ai-agents-the-new-enterprise-vulnerability">Prompt Injection Attacks on AI Agents: The New Enterprise</a></li>

</ul>
</details>

**社区讨论**: 评论者大多认为这一漏洞是预期结果而非意外发现，arjie 将其与"curl $url | bash 可以窃取数据"相提并论——暗示这种风险是可以预见的。pwarner 批评微软匆忙将功能推向生产环境，称他们"急于保持相关性"。Simonw 强调数据外泄应该是任何代理产品开发者需要考虑的"首要风险"，而 EFLKumo 则将其置于 LLM 系统对抗提示注入攻击的整体困境中进行考量。

**标签**: `#security`, `#prompt-injection`, `#microsoft-copilot`, `#LLM-agents`, `#data-exfiltration`

---

## [方济各十四世通谕探讨科技权力集中问题](https://www.vatican.va/content/leo-xiv/en/encyclicals/documents/20260515-magnifica-humanitas.html) ⭐️ 8.0/10

2026 年 5 月 15 日，方济各十四世发布了其首份通谕《Magnifica Humanitas》（壮丽人性），探讨人工智能、生物技术和核能等新兴技术如何将前所未有的权力集中到拥有知识和经济资源的人手中。 这代表了科技伦理领域的一个重大制度性声音，梵蒂冈的道德权威为人工智能和新兴技术正在造成影响全人类的危险权力不对称这一担忧增添了分量。 文件指出'技术从来不是中性的，因为它具有那些设计、资助、监管和使用它的人的特征'，认为建造者承担着'特殊的伦理和精神责任'，因为'每一个设计选择都反映了对人类的愿景'。

hackernews · theletterf · May 25, 10:11 · [社区讨论](https://news.ycombinator.com/item?id=48265206)

**背景**: 通谕是教皇撰写的 pastoral 信函，主要面向主教，也面向天主教徒和所有人，传授关于道德或社会挑战的权威教导。方济各十四世（本名罗伯特·普雷沃斯特）于 2025 年秘密会议中当选，成为历史上首位美国教皇，选择此名是为了呼应教皇利奥十三世在第一次工业革命期间对工人和公平的关注。他是首位来自圣奥古斯丁修会的教皇，并一直强调与技术挑战的互动。

<details><summary>参考链接</summary>
<ul>
<li><a href="https://en.wikipedia.org/wiki/Pope_Leo_XIV">Pope Leo XIV</a></li>
<li><a href="https://www.nytimes.com/2026/05/25/world/europe/pope-leo-encyclical-ai.html">Pope Leo Has Released an Encyclical About A.I. Why Is That...</a></li>

</ul>
</details>

**社区讨论**: 社区反响非常积极，包括一位无神论者评论者称赞梵蒂冈的技术分析是'我见过的任何机构/政府中最好的观点之一'。讨论集中在技术是自然集中权力还是可以被塑造以造福更广泛的社会，参与者质疑传统的'我们能建造它吗？'和'人们会想要它吗？'的问题，转而考虑更深层次的文明考量。

**标签**: `#AI ethics`, `#technology policy`, `#religious-institution`, `#power-concentration`, `#societal-impact`

---

## [加州将 Linux 从年龄验证法中豁免](https://www.tomshardware.com/software/linux/california-moves-to-exempt-linux-from-its-upcoming-age-verification-law-after-backlash-over-forcing-operating-systems-to-collect-users-ages-amendment-proposed-by-the-same-lawmaker-who-wrote-the-original-law) ⭐️ 7.0/10

加州正在推进一项修正案，将 Linux 从 AB 2273（加州适龄设计法典）规定的年龄验证要求中豁免。该修正案由最初起草该法案的同一位立法者提出，原始法案要求操作系统在设备设置过程中收集用户年龄，生效日期为 2027 年 1 月 1 日。 这一豁免代表了开源社区的重大胜利，防止了可能影响 Linux 发行版全球运营方式的广泛法规。这一结果表明，基层倡导可以成功影响科技政策，可能为未来全球范围内开源软件的法律待遇开创先例。 修正案认识到，对开源系统实施年龄验证要求会在容易被规避的同时带来新的隐私风险。AB 2273 法案要求可能为 18 岁以下用户使用的在线服务以"合理程度的确定性"估算儿童用户的年龄，违规罚款可能高达 180 亿美元。

hackernews · rbanffy · May 25, 18:19 · [社区讨论](https://news.ycombinator.com/item?id=48269961)

**背景**: AB 2273 于 2022 年 9 月 15 日颁布，以英国适龄设计法典为蓝本，英国该法典于 2021 年 9 月生效。加州法律旨在通过要求平台实施年龄估算或验证机制来保护儿童在线安全。年龄验证系统使用技术方法来限制对特定年龄以下用户不当内容的访问。该法律的广泛范围最初扩展到操作系统，这将要求 Linux 发行版在设置过程中实施年龄收集机制。

<details><summary>参考链接</summary>
<ul>
<li><a href="https://www.theverge.com/tech/930573/age-verification-bills-linux-open-source">Linux devs are fighting the new age -gated internet | The Verge</a></li>
<li><a href="https://en.wikipedia.org/wiki/Social_media_age_verification_laws_in_the_United_States">Social media age verification laws in the United States - Wikipedia</a></li>

</ul>
</details>

**社区讨论**: 社区评论显示出复杂的情绪和重要的批评。几位评论者质疑这些互联网法律究竟是谁起草的，加州的科技公司是否被咨询过，其中一人观察到"公共机构已经失去了监管公司的意愿或能力，所以他们转而将负担转嫁给消费者。"其他人则提出替代方案，例如让浏览器检查家长控制功能，而不是在操作系统层面强制要求年龄验证。一个讽刺性的评论认为，豁免可能是特意设计的，这样 Linux 开发者就缺乏对法律提出第一修正案挑战的法律地位。一些声音指出，大多数评论者误解了法律的真实内容。

**标签**: `#tech-policy`, `#linux`, `#age-verification`, `#california-legislation`, `#open-source`

---

## [C 编译器扩展的移植性挑战](https://lemon.rip/w/6-c-extensions-compilers/) ⭐️ 7.0/10

Hacker News 上的讨论突出了各平台间 C 编译器扩展的移植性问题，展示了不完整的__attribute__检查等有问题的代码模式，并引用 D 语言的 ImportC 作为实用的解决方案。 主要在 Linux 系统上编写的 C 代码常因 GNU 特定扩展而无法在 Windows 和 FreeBSD 上编译，为面向多平台开发的程序员带来重大困扰，并限制了代码的可移植性。 讨论引用了有问题的代码示例，如条件编译只检查 GCC、Clang 或 TinyCC，却未验证__attribute__是否已定义。评论者也提到 slimcc 的测试脚本和平台头文件 hack，作为独立编译器开发者的有用资源。

hackernews · xngbuilds · May 25, 14:15 · [社区讨论](https://news.ycombinator.com/item?id=48267126)

**背景**: GNU C 编译器提供超出 ISO 标准 C 的语言扩展，包括嵌套函数、零长度数组、typeof 关键字和范围 case 标签。这些扩展在 GCC 的-std=gnu11 模式下默认可用。虽然很有用，但依赖这些扩展会在代码必须在非 GCC 编译器上编译时产生移植性问题。ImportC 是内置于 D 语言编译器中的 C 编译器，旨在处理来自各平台的头文件的复杂性。

<details><summary>参考链接</summary>
<ul>
<li><a href="https://gcc.gnu.org/onlinedocs/gcc-12.2.0/gcc/C-Extensions.html">C Extensions (Using the GNU Compiler Collection (GCC))</a></li>
<li><a href="https://sergioprado.blog/gcc-extensions-to-the-c-language/">GCC extensions to the C language - sergioprado.blog GNU C Language Extensions - GitHub Pages Extensions to the C Language Family - Using the GNU Compiler ... Using and Porting the GNU Compiler Collection (GCC ... Clang Language Extensions — Clang 23.0.0git documentation</a></li>

</ul>
</details>

**社区讨论**: 社区成员分享了对'在我机器上能用'的 C 代码在 Windows 和 FreeBSD 上失败的沮丧感。几位评论者称赞 Common Lisp 的生态系统是多个实现共同演进、通过可移植性库协作的典范。整体观点强调，C 社区可以从类似的标准化努力中受益，尤其是在标准委员会数十年相对不活跃的情况下。

**标签**: `#C programming`, `#compiler portability`, `#cross-platform development`, `#language design`, `#GNU extensions`

---

## [挪威使用华为存储构建主权挪威语大模型](https://www.blocksandfiles.com/flash/2026/05/22/norways-2-petabytes-of-huawei-flash-storage-and-llm-training/5244910) ⭐️ 6.0/10

挪威正在开发名为 Olivia 的主权挪威语大语言模型，使用了 2 拍字节的华为闪存存储和一台配备 448 个 GPU 及 64,512 个 CPU 核心的 HPE Cray 超级计算系统。 该项目代表了挪威通过专门训练一个基于挪威语言、历史和文化的大语言模型来推动 AI 主权。这也引发了关于资源有限的国家 AI 计划是否能够有效与资源充足的前沿模型竞争的重要问题。 Olivia 系统运行在 HPE Cray 超级计算 EX 架构上。社区专家质疑 448 个 GPU 是否足以训练完整的大语言模型，建议在开源模型上进行 LoRA 微调可能更加实用。一些人建议与现有模型构建者共享挪威语训练数据集可能会以更低成本实现相同目标。

hackernews · rbanffy · May 25, 19:37 · [社区讨论](https://news.ycombinator.com/item?id=48270770)

**背景**: AI 主权是指一个国家使用自己的数据、基础设施和专业知识开发和控制 AI 系统的能力。大语言模型(LLM)通常使用数千个 GPU 在数周或数月内对海量数据集进行训练，需要大量计算资源。挪威的倡议旨在通过 AI 系统保护挪威语言和文化，解决以英语为中心的前沿模型可能缺乏对非英语国家历史和文化背景深入了解的担忧。

<details><summary>参考链接</summary>
<ul>
<li><a href="https://www.constellationr.com/insights/news/hpe-launches-greenlake-llms-aims-democratize-cray-supercomputing-ai-training">HPE launches GreenLake for LLMs, aims to democratize Cray ...</a></li>
<li><a href="https://institute.global/insights/tech-and-digitalisation/sovereignty-in-the-age-of-ai-strategic-choices-structural-dependencies">Sovereignty in the Age of AI: Strategic Choices, Structural ...</a></li>

</ul>
</details>

**社区讨论**: 社区对挪威技术方案的可行性表示严重质疑。一位评论者认为 448 个 GPU 对于训练完整的大语言模型来说远远不够，建议在开源模型上进行 LoRA 微调会更实用。另一位建议挪威应该建立并与现有模型构建者共享挪威语训练数据集，使前沿模型了解挪威语言和文化。一位评论者质疑前沿模型是否已经在训练挪威语内容，对主权模型是必要的这一前提提出疑问。

**标签**: `#AI sovereignty`, `#LLM training`, `#infrastructure`, `#national AI strategy`, `#Norway`

---

## [Exit IP VPN servers mitigation rollout](https://mullvad.net/en/help/exit-ip-vpn-servers-mitigation-rollout) ⭐️ 6.0/10

Mullvad VPN's mitigation rollout for exit IP fingerprinting on servers is discussed, with community comments covering related fingerprinting issues, Mullvad Browser's proxy features, and questions about VPN infrastructure costs.

hackernews · Cider9986 · May 25, 17:45 · [社区讨论](https://news.ycombinator.com/item?id=48269580)

**标签**: `#vpn`, `#privacy`, `#fingerprinting`, `#mullvad`, `#security`

---

