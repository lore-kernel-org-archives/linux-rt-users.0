From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec: reenable HPET before kexec
Date: Mon, 27 Aug 2007 12:33:00 -0600
Message-ID: <m1zm0c4ylf.fsf@ebiederm.dsl.xmission.com>
References: <20070820205530.1ffd5876@windmill.dev.rtsoft.ru>
	<20070823090845.GA13065@in.ibm.com>
	<20070823154936.3b7ae498@windmill.dev.rtsoft.ru>
	<20070827053656.GC9809@in.ibm.com>
	<653FFBB4508B9042B5D43DC9E18836F501522051@scsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <vgoyal@in.ibm.com>,
	"Konstantin Baydarov" <kbaidarov@ru.mvista.com>,
	"RT" <linux-rt-users@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"Andi Kleen" <ak@suse.de>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932689AbXH0Sdm@vger.kernel.org>
In-Reply-To: <653FFBB4508B9042B5D43DC9E18836F501522051@scsmsx415.amr.corp.intel.com>
	(Venkatesh Pallipadi's message of "Mon, 27 Aug 2007 11:26:29 -0700")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> writes:

> - Another thing to try is to disable HPET and boot with PIT in the first
> kernel. Just to check whether PIT never works on this platform or the
> first kernel is doing something to stop PIT. You can try "hpet=disable"
> boot option for that.

I don't know what the original patch looked like.  It doesn't
seem to have made it to any mailling lists to which I'm subscribed.
But I'm wondering of there is a bug in the shutdown routines for
the pit or the hpet that is causing problems.  As this is
a normal kexec those routines will get called.

Eric
