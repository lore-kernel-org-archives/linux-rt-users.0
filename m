Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvR1GRui"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91AE197
	for <linux-rt-users@vger.kernel.org>; Wed, 22 Nov 2023 05:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700660188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YjOh8x+CSQGbj4xPSaSmIWfs0CZGrfs1HuMmaw6zk28=;
	b=UvR1GRuivOL+0dAw0PMjvUwwezGq5OBMXEeEeB1PYkuiJiPphuOzK/eF3eXldZKbHi9rgp
	Mc/hImpT0Z1lM45McELFlTKpXtW3ekampOHXGZu8ZG7nc9DkhE2MqtptoArB/oL0sftTmi
	rbIl9qh5/iWMIThGdPCP/OD40l/WzuA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-phECgDT5Mb2RugjusxQuHw-1; Wed,
 22 Nov 2023 08:36:25 -0500
X-MC-Unique: phECgDT5Mb2RugjusxQuHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEF353C027A7;
	Wed, 22 Nov 2023 13:36:24 +0000 (UTC)
Received: from localhost (unknown [10.22.8.167])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2662A1121308;
	Wed, 22 Nov 2023 13:36:24 +0000 (UTC)
Date: Wed, 22 Nov 2023 10:36:23 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <ZV4D1yBGSOE-OVUF@uudg.org>
References: <ZV1S4yDcPKwj5_N1@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV1S4yDcPKwj5_N1@uudg.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Tue, Nov 21, 2023 at 10:01:25PM -0300, Luis Claudio R. Goncalves wrote:
> Hello RT-list!
> 
> I'm pleased to announce the 5.10.201-rt98 stable release.
> 
> This release is just an update to the new stable 5.10.201
> version and no RT changes have been made.
> 
> You can get this release via the git tree at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> 
>   branch: v5.10-rt
>   Head SHA1: 3a93f0a0d49dd0db4c6876ca9a7369350e64320e

Greg KH,

While testing v5.10.201-rt98 I stumbled over this warning:

    [ 1000.312397] run blktests nvme/005 at 2023-11-21 21:46:30
    ...
    [ 1000.500478] workqueue: WQ_MEM_RECLAIM nvmet_tcp_wq:nvmet_tcp_io_work [nvmet_tcp] is flushing !WQ_MEM_RECLAIM events:0x0
    [ 1000.500490] WARNING: CPU: 0 PID: 6 at kernel/workqueue.c:2620 check_flush_dependency+0x11f/0x140

That seems to be fixed by:

    533d2e8b4d5e4 nvmet-tcp: fix lockdep complaint on nvmet_tcp_wq flush during queue teardown
        (and depending on what else is backported)
        ddd2b8de9f85b nvmet: fix workqueue MEM_RECLAIM flushing dependency

Is this something that can be added to your v5.10 queue or should I carry
this fix on v5.10-rt in the meantime?

Thank you in advance!
Luis

> Or to build 5.10.201-rt98 directly, the following patches should be applied:
> 
>   https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz
> 
>   https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.201.xz
> 
>   https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.201-rt98.patch.xz
> 
> Signing key fingerprint:
> 
>   9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26
> 
> All keys used for the above files and repositories can be found on the
> following git repository:
> 
>    git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
> 
> Enjoy!
> Luis
> 
---end quoted text---

