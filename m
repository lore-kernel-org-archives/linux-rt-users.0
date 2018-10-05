From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] rt: convert mm/kasan/quarantine_lock to raw_spinlock
Date: Fri, 5 Oct 2018 18:37:55 +0200
Message-ID: <20181005163754.2eexrmhzvdltswdr@linutronix.de>
References: <20180918152931.17322-1-williams@redhat.com>
 <201809190442.itGUBZK3%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clark Williams <williams@redhat.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201809190442.itGUBZK3%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-09-19 04:34:50 [+0800], kbuild test robot wrote:
> Hi Clark,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linux-rt-devel/for-kbuild-bot/current-stable]
> 
> url:    https://github.com/0day-ci/linux/commits/Clark-Williams/rt-convert-mm-kasan-quarantine_lock-to-raw_spinlock/20180919-021343
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git for-kbuild-bot/current-stable
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):

how is this related? Could someone please explain this.

Sebastian
