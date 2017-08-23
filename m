From: Michal Hocko <mhocko@kernel.org>
Subject: Re: All process has been hanged after a kernel WARNING in kernel
 4.4.x
Date: Wed, 23 Aug 2017 14:57:33 +0200
Message-ID: <20170823125732.GC2647@dhcp22.suse.cz>
References: <2B18E8E1DDAE074A82D1060396451DAE26407871@CNMAILEX03.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Tong Tong3 Li <litong3@lenovo.com>
To: Feng Feng24 Liu <liufeng24@lenovo.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2B18E8E1DDAE074A82D1060396451DAE26407871@CNMAILEX03.lenovo.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed 23-08-17 12:40:36, Feng Feng24 Liu wrote:
> Dear experts
> 	I install kernel 4.4.70-rt83 in my environment, and run QEMU-KVM & OVS-DPDK on my server.

Is this reproducible? If yes could you try without RT patches applied to
know this is applicable to vanilla kernel as well?

> 	After a kernel warning, I found that all of the process, such as sshd, has no response. The monitor cannot displayed. All process looks like has been hanged. But the server could be ping. 

The warning tells that we have underflown the counter and that can have
variety of side effects.
[...]
> 	I find there is a discuss at:
> 	https://lkml.org/lkml/2015/12/3/460

from a quick glance this doesn't seem related.

> 	Whether it is the same problem as above?  Is it a known issue , which has not been fixed in kernel 4.4.x?

I haven't seen any such reports.
-- 
Michal Hocko
SUSE Labs
