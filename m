From: Daniel Wagner <wagi@monom.org>
Subject: Re: hrtimer become inaccurate with RT patch
Date: Fri, 6 Jul 2018 16:22:16 +0200
Message-ID: <bce8b710-a57b-fb7b-f784-b13d415aa451@monom.org>
References: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com>
 <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
 <20180702101420.rskzwqrdyws5fl6m@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        anna-maria@linutronix.de, john.stultz@linaro.org,
        Hangaohuai <hangaohuai@huawei.com>,
        "zhangjianwei (D)" <zhangjianwei8@huawei.com>,
        yangchuanlong@huawei.com,
        "Zhangbin (EulerOS)" <zhangbin46@huawei.com>,
        liupeifeng3@huawei.com
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        gengdongjiu <gengdongjiu@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702101420.rskzwqrdyws5fl6m@breakpoint.cc>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 07/02/2018 12:14 PM, Sebastian Andrzej Siewior wrote:
> On 2018-07-02 17:34:34 [+0800], gengdongjiu wrote:
>>    The Linux kernel version is v4.1.46, and the preempt_rt patch is
>> patch-4.1.46-rt52.patch.
> 
> the 4.1 series is no longer supported (neither RT wise nor non-RT,
> https://www.kernel.org/category/releases.html). I suggest to move away.
> If you notice this problem now it is hardly a long running project.

Who can edit this page:

https://wiki.linuxfoundation.org/realtime/preempt_rt_versions

? It still lists 4.1-rt as supported.
