From: Rong Chen <rong.a.chen@intel.com>
Subject: Re: [kbuild-all] [PATCH RT] rt: convert mm/kasan/quarantine_lock to
 raw_spinlock
Date: Thu, 18 Oct 2018 17:04:01 +0800
Message-ID: <83c8a7a7-00be-b29b-fa2e-be9c8276be94@intel.com>
References: <20180918152931.17322-1-williams@redhat.com>
 <201809190442.itGUBZK3%fengguang.wu@intel.com>
 <20181005163754.2eexrmhzvdltswdr@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kbuild test robot <lkp@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005163754.2eexrmhzvdltswdr@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 10/06/2018 12:37 AM, Sebastian Andrzej Siewior wrote:
> On 2018-09-19 04:34:50 [+0800], kbuild test robot wrote:
>> Hi Clark,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on linux-rt-devel/for-kbuild-bot/current-stable]
>>
>> url:    https://github.com/0day-ci/linux/commits/Clark-Williams/rt-convert-mm-kasan-quarantine_lock-to-raw_spinlock/20180919-021343
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git for-kbuild-bot/current-stable
>> config: x86_64-allmodconfig (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
>> reproduce:
>>          # save the attached .config to linux build tree
>>          make ARCH=x86_64
>>
>> All warnings (new ones prefixed by >>):
> how is this related? Could someone please explain this.
>
>
It Iooks like a kbuild issue, we will looking into it.

Best Regards,
Rong Chen
