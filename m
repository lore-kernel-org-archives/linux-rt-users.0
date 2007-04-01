From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.21-rc5-rt6 make errors
Date: Sun, 1 Apr 2007 20:39:28 +0200
Message-ID: <20070401183928.GB27614@elte.hu>
References: <23932.213.58.131.130.1170156409.squirrel@www.rncbc.org> <460FE7F3.4060303@rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Rui Nuno Capela <rncbc@rncbc.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933853AbXDASjc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <460FE7F3.4060303@rncbc.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Hi,
> 
> Just tried to build 2.6.21-rc5-rt6 and it is failing on build time.

> Just to let you know that -rt5 was doing fine with very same .config .

oops - indeed! I've uploaded -rc5-rt7 with the fix. (it includes a few 
other fixes as well)

note that for Fedora-ish distros there's an easy yum test-kernel 
available from the rt-testing repo:

cat > /etc/yum.repos.d/rt-testing.repo
[rt-testing]
name=Ingo's Real-Time (-rt) test-kernel for FC6
baseurl=http://people.redhat.com/mingo/realtime-preempt/yum-testing/yum/
enabled=1
gpgcheck=0
<Ctrl-D>

this includes Linus-git-bleeding-edge as well as the base kernel. (rt7 
is based on upstream HEAD 755948cfca16c7)

[the rt-testing repo currently includes the rt6 rpm, i've just started 
the rt7 build, it should be available in half an hour or so]

	Ingo
