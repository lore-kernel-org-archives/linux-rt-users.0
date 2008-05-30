From: Tarkan Erimer <tarkan@netone.net.tr>
Subject: Re: 2.6.25.4-rt4
Date: Fri, 30 May 2008 10:37:40 +0300
Message-ID: <483FAEC4.1030607@netone.net.tr>
References: <1212076754.24785.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755912AbYE3Hhw@vger.kernel.org>
In-Reply-To: <1212076754.24785.18.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven Rostedt wrote:
> We are pleased to announce the 2.6.25.4-rt4 tree, which can be
> downloaded from the location:
>
>   

Hi,

I just downloaded and tried to compile it. But I got the following error 
message at compile stage. I use Kubuntu-8.04 with linux-2.6.25.4-rt3 
without problems.

kernel/sched.c: In function 'sched_init':
kernel/sched.c:7677: error: implicit declaration of function 
'global_rt_runtime'
make[2]: *** [kernel/sched.o] Error 1
make[1]: *** [kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.25.4'
make: *** [debian/stamp-build-kernel] Error 2
