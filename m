From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: 2.6.28-rt on PowerPC
Date: Thu, 29 Jan 2009 15:21:55 -0800
Message-ID: <49823A13.50703@am.sony.com>
References: <20090129213429.GA29014@oksana.dev.rtsoft.ru> <1233270043.3833.57.camel@localhost.localdomain>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: avorontsov@ru.mvista.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <srostedt@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759989AbZA2XWl@vger.kernel.org>
In-Reply-To: <1233270043.3833.57.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven Rostedt wrote:
> On Fri, 2009-01-30 at 00:34 +0300, Anton Vorontsov wrote:
>> Hi Steven,
>>
>> I know 2.6.28-rt isn't yet ready, but I could not resist to try
>> it anyway. ;-)
>>
>> Here are few issues and ways to solve them:
>>
>> Currently the -rt tree doesn't link for arch/powerpc:
>>
>>   LD      .tmp_vmlinux1
>>   arch/powerpc/kernel/built-in.o: In function `show_interrupts':
>>   (.text+0x27bc): undefined reference to `__call_bad_lock_func'
>>   arch/powerpc/kernel/built-in.o: In function `show_interrupts':
>>   (.text+0x28b0): undefined reference to `__call_bad_lock_func'
>>   make: *** [.tmp_vmlinux1] Error 1
> 
> Thanks! I have not yet had the chance to apply any arch patches yet. I
> do plan on doing so after getting the code mostly working on x86.

Your email can at an opportune time for me...  I was starting to try
2.6.28-rt on ARM and quickly came to the conclusion that the arch
patches weren't the focus yet.  But I'm currently side-tracked with
getting my board to even boot a vanilla 2.6.28 kernel first.  Do
you expect to get to the arches in the next week or two?  If not,
I may head down that path for ARM myself.

Thanks!

-Frank Rowand
