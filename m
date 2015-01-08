From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Help regarding Cyclictest.
Date: Thu, 8 Jan 2015 11:42:32 -0500
Message-ID: <20150108114232.6c0fc37f@gandalf.local.home>
References: <CAOZUVQzdrVL6vz5NaLfaXcSovOKNjE9M7Vi4QguVLaUyDDCdog@mail.gmail.com>
 <20141223122606.11f2ff27@sluggy>
 <CAOZUVQx+YEQu7_QBDqg-HNeM7B0OqyaPeW=V5uUQWrPMoa7c7w@mail.gmail.com>
 <CAOZUVQzxATsud4L8+Z7EFRTyp9Jhu5nNcS5TyLZxWDo46R+6Dg@mail.gmail.com>
 <20141228163640.2d50be80@sluggy>
 <CAOZUVQwOgcNkJz46E0rDy_8W-Po=cSkTLg2gf7sQc9XRNftUyw@mail.gmail.com>
 <20150106152649.0cb27c34@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ipsit Kumar <kumaripsit1@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:39721 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754618AbbAHQmg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Jan 2015 11:42:36 -0500
In-Reply-To: <20150106152649.0cb27c34@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 6 Jan 2015 15:26:49 -0600
Clark Williams <williams@redhat.com> wrote:

> 
> On Fri, 2 Jan 2015 15:02:11 +0530
> Ipsit Kumar <kumaripsit1@gmail.com> wrote:
> 
> > Hi sir,
> > Good Afternoon.
> > Thank you for your reply.
> > 
> > I am facing some issues with cyclictest.
> > Basically i am using this tool on ARM platform, specifically on TCI6614 evm.
> > I am seeing strange spike in the cyclictest result.

What kernel are you running?

> > 
> > 
> > 
> > 
> > 
> > *root # ./cyclictest -t1 -p80 -i 10000 -l 10000# /dev/cpu_dma_latency set
> > to 0uspolicy: fifo: loadavg: 0.70 0.48 0.61 1/434 15283           T: 0
> > (15226) P:80 I:10000 C:  10000 Min:      5 Act:    9 Avg:   17 Max:    5797*
> > 
> > When I am plotting the Histogram, I see the latency to go beyond 3ms once.
> > I am unable to figure out what is the reason behind this.
> > Checked with the kernel configuration and found that the CPU Frequency
> > scaling is Disabled.
> > No power management features are enabled.
> > 
> > It would be a great help, if you could point out something I am doing
> > wrong.
> > 
> > Thank you.
> 
> Sorry for the slow response time, but I've been swamped with things
> here at work following the Christmas break. 
> 
> First, I don't see anything offhand that you're doing wrong. What
> version of the realtime kernel are you running? 
> 
> I think your best bet may be to take this to the Linux Realtime users
> mailing list (in CC). 
> 
> To get a sense of where things are going wrong, you can run cyclictest
> with the -b option, like this:
> 
> $ cyclictest -t1 -p80 -i 10000 -l 10000 -b 500

You can also download the latest trace-cmd with the profile feature and
try this:

 # trace-cmd profile --stderr -F -c cyclictest -t1 -p80 -i 10000 -l
 10000 2> profile.out

And when you see the spike, hit ctrl-C and see the output.


Get the latest at:

 git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/trace-cmd.git

-- Steve

> 
> This will enable the ftrace system and will cause the event tracepoints
> to be enabled. When a latency is measured greater than the specified
> argument (in this case 500 microseconds), cyclictest will first stop
> ftrace and will then exit. You can at that point use the trace-cmd
> command to save off the trace buffers:
> 
> $ trace-cmd extract
> 
> This will generate the file trace.bin which is a binary
> representation of the kernel trace buffers. You can then generate a
> latency trace report using:
> 
> $ trace-cmd report -l
> 
> This will give you an idea of what code paths were taken prior to the
> latency spike. From here it's a matter of figuring out what happened
> and how to prevent it from happening.
> 
