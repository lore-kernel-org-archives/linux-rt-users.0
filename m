From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: kernel BUG at kernel/locking/rtmutex.c:1027
Date: Thu, 8 Jun 2017 09:45:45 -0400
Message-ID: <20170608094545.67901a4f@gandalf.local.home>
References: <2B18E8E1DDAE074A82D1060396451DAE263C7C1A@CNMAILEX04.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tmac@hp.com" <tmac@hp.com>, Tong Tong3 Li <litong3@lenovo.com>
To: Feng Feng24 Liu <liufeng24@lenovo.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2B18E8E1DDAE074A82D1060396451DAE263C7C1A@CNMAILEX04.lenovo.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 8 Jun 2017 07:01:08 +0000
Feng Feng24 Liu <liufeng24@lenovo.com> wrote:

> Hi,  T Makphaibulchoke & Steve
> 	I found that you discuss about " kernel BUG at kernel/locking/rtmutex.c:997 " at 
> 	https://groups.google.com/forum/#!topic/fa.linux.kernel/aV2peeXs71E
> 	
> 	Could you help to give some advice? 
> 	Our kernel version is:  kernel4.4.6-rt14
> 	Whether our problem ,which I describe above, is the same problem as " kernel BUG at kernel/locking/rtmutex.c:997"?  
> 	And why is the patch "[PATCH 3.14.25-rt22 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at kernel/locking/rtmutex.c:997!" not apply to the upsteam or rt-patches? 

You mean commit 8fe55d0c10959a4f2b6e9efe57a8698ce2fa2f33 that was added
in v4.4.50-rt63?

-- Steve

> 	
> 	Thanks a lot
> 
> Thanks
> Feng
> 
