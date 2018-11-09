From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: arm64 + ARM64_64K_PAGES=y
Date: Fri, 9 Nov 2018 10:12:37 +0530
Message-ID: <5d7cde17-67c4-a222-bd66-b0e85a8725fe@arm.com>
References: <1ab7ee03-64fe-384a-c88f-f6d519b965db@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1ab7ee03-64fe-384a-c88f-f6d519b965db@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 11/07/2018 03:04 AM, Grygorii Strashko wrote:
> Hi All,
> 
> Do anybody tried to use ARM64 RT with 76K pages enabled?
> 
> My attempt shows that enabling  CONFIG_ARM64_64K_PAGES=y increases latencies by ~30%

Depends on what the workload is actually doing. 64K pages should help if
the mapping is multiple of 64K, persistent and accesses patterns are more
or less linear to be nice with the TLB. 64K can take bit more time if the
memory requirement is way smaller than 64K in which case latency probably
can increase just to zero out the single page allocated. Latency can add
up if this happens on a regular basis. perf report can help find out more
on this.
