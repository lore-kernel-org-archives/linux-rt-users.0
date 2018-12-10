From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: Disable RT_GROUP_SCHED in PREEMPT_RT_FULL
Date: Mon, 10 Dec 2018 15:50:20 +0800
Message-ID: <194aa1b6-0d98-d4ef-397a-a6ddca02cc6a@huawei.com>
References: <tencent_4E2198ADDEAE31C784F2AD886A44A9E3C605@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb18030"
Content-Transfer-Encoding: 8bit
To: zhang jianwei <jianwei_z@foxmail.com>, tglx <tglx@linutronix.de>,
        efault <efault@gmx.de>, <linux-rt-users@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <tencent_4E2198ADDEAE31C784F2AD886A44A9E3C605@qq.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Loop RT kernel Mailing lists.


On 2018/12/10 1:04, zhang jianwei wrote:
> hi Thomas and Mike，
> i say you disabled the RT_GROUP_SCHED in RT kernel because of strange cpu stall was observed. currently, in my projects, I need enable RT_GROUP_SCHED in RT kernel. I’d like to know how to reproduce the strange cpu stall in order to fix this bug. can you guys give me some advice  about how to fix this problem.
> Thanks in advance!
> 
> 
> patched mentioned 
> https://lore.kernel.org/patchwork/patch/313215/
> 
> 
