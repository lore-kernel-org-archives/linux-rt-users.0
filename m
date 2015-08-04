From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [RT] oops in 4.1.3-rt3
Date: Tue, 4 Aug 2015 10:08:29 +0200
Message-ID: <20150804080829.GB9956@opentech.at>
References: <20150803142700.1de720e4@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150803142700.1de720e4@sluggy>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 03 Aug 2015, Clark Williams wrote:

> Sebastian,
> 
> Below is a traceback I hit while running 4.1.3-rt3 on my Lenovo T530.
> 
> I was doing my normal, play music, copy files over the lan, do compiles,
> do email, etc., so I I can't really point you at a reproducer. The graphics
> system stayed up somewhat but the actual trace I hit scrolled off. This was
> extracted from the syslog with 'journalctl'. 
> 
> If I encounter it again, I'll see if I can force a kdump. 
>
have an i7 8-core here running 4.1.3-rt3 that is more or less idle (about 3 
days) only one ssh login over the network running top and no other user logged 
in - just the default processes of Debian 8.1 active and it slowly grinds
to a halt (no rt user-space tasks running). the last screen that top 
displayed was

<snip>
    3 root      -2   0       0      0      0 R  60.3  0.0   5756:16 ksoftirqd/0 
   23 root      -2   0       0      0      0 R  50.8  0.0   4948:08 ksoftirqd/2
   17 root      -2   0       0      0      0 S  50.6  0.0   4897:13 ksoftirqd/1
   29 root      -2   0       0      0      0 S  50.4  0.0   4953:24 ksoftirqd/3
   10 root      20   0       0      0      0 R  17.0  0.0   1836:35 rcuc/0     
    1 root      20   0  177192   5628   3040 R  15.0  0.0   1715:07 systemd    
   16 root      20   0       0      0      0 R  14.8  0.0   1780:42 rcuc/1     
    7 root      20   0       0      0      0 R  12.6  0.0 717:42.70 rcu_preempt
15052 hofrat    20   0   23640   2792   2352 R  11.5  0.0   0:54.54 top        
 1205 root      20   0       0      0      0 R  10.0  0.0 812:43.02 kworker/0:2
 1524 message+  20   0   43544   4624   3000 R   8.2  0.0   1049:19 dbus-daemon
 2070 root      20   0  307568  10492   9420 S   8.0  0.1   1023:26 packagekitd
<snip>

but I did not get any traces in syslog and no details that are of any help
it would be interesting though to know if there is a similarity in the top 
tasks on the system.

thx!
hofrat
