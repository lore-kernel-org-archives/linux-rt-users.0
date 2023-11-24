Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5533CC5;
	Fri, 24 Nov 2023 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cxpshLMN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED18DC433C7;
	Fri, 24 Nov 2023 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700842297;
	bh=dJSDLgF1ETBLHdgapdUQqr7W+2GHFxTIN1LSwAqVspg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxpshLMNbgBo+zf0EEVWtwlzwlDDJS8GI5vOpggbBc/4eGORnPz9ml/oppewA7Td7
	 e0maD+CCVcnC6AF5S3tqdFUrOQtUeViomwCQvryMArVneUAizDUVvDBndcbRSKUP6B
	 RvQirFT0Z6LVpidAvmBw87tTwgJ0yLAjxn1z16SI=
Date: Fri, 24 Nov 2023 16:11:35 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.201-rt98
Message-ID: <2023112455-anytime-unmapped-ed7d@gregkh>
References: <ZV1S4yDcPKwj5_N1@uudg.org>
 <ZV4D1yBGSOE-OVUF@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV4D1yBGSOE-OVUF@uudg.org>

On Wed, Nov 22, 2023 at 10:36:23AM -0300, Luis Claudio R. Goncalves wrote:
> On Tue, Nov 21, 2023 at 10:01:25PM -0300, Luis Claudio R. Goncalves wrote:
> > Hello RT-list!
> > 
> > I'm pleased to announce the 5.10.201-rt98 stable release.
> > 
> > This release is just an update to the new stable 5.10.201
> > version and no RT changes have been made.
> > 
> > You can get this release via the git tree at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> > 
> >   branch: v5.10-rt
> >   Head SHA1: 3a93f0a0d49dd0db4c6876ca9a7369350e64320e
> 
> Greg KH,
> 
> While testing v5.10.201-rt98 I stumbled over this warning:
> 
>     [ 1000.312397] run blktests nvme/005 at 2023-11-21 21:46:30
>     ...
>     [ 1000.500478] workqueue: WQ_MEM_RECLAIM nvmet_tcp_wq:nvmet_tcp_io_work [nvmet_tcp] is flushing !WQ_MEM_RECLAIM events:0x0
>     [ 1000.500490] WARNING: CPU: 0 PID: 6 at kernel/workqueue.c:2620 check_flush_dependency+0x11f/0x140
> 
> That seems to be fixed by:
> 
>     533d2e8b4d5e4 nvmet-tcp: fix lockdep complaint on nvmet_tcp_wq flush during queue teardown
>         (and depending on what else is backported)
>         ddd2b8de9f85b nvmet: fix workqueue MEM_RECLAIM flushing dependency
> 
> Is this something that can be added to your v5.10 queue or should I carry
> this fix on v5.10-rt in the meantime?

That's odd, as this commit is already in the 5.10.138 release, so how
can we apply it again?

confused,

greg k-h
