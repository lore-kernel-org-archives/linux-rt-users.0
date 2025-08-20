Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C81299AB5
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Aug 2025 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723227; cv=none; b=UI5aLqKDl0ROsVCRdCrx5pgCGjw25eBLOFQ9L1q42qljq1sJXlZUk/BApQGF8cRMMwjMDjBtT02BLlxXQX0CAoimVm2TSPPBlTKPjU6zNiloOFfzMijAomlWeBaB+PvcFfRSQXInx4cuSunI3ztWcXyKqUhUkkv06Chv5HFs2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723227; c=relaxed/simple;
	bh=7YIPuvj5PsdKRSiVp5WUnMrka/bkauSBh/YrEyTZ2Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoIct9Puu+Hv2xbCCq3qSPur3YgAbZn1H38m8DPMKZVo+Wyni6LgbKvSwAnq3tDgX0krrz5Gx36coKFtLqdBYNKAQ2LSwb0rMcLOhc5tCQA7T4d+CmRapx0k8hQ9tqBZwl29Mq9weyFPHW846Jj7gHcu+3raEPB3/m0W6V9xi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdiDRPh9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdiDRPh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755723223;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=onU2+yXr6fBh6V3TsxBM+IzkdMA/4TG4V+cX05iwnaw=;
	b=bdiDRPh9LjgsBpjsb17U6p1I66KH3O6WdovnAcF+AGfhdnodBe5MzUjVR8TMtbT7U9q2wl
	UgQoSMGKdxiBcv22RYy9XezS6ICokAPUnrKHe+KCzxomC/uT/0Nc6TWNs8N69Gr/XzLJXu
	m2ZO5cUl/+pVCGj+5JOsY7/PoLmtIJc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-R_27agvHM0WN-GsJvH5glg-1; Wed,
 20 Aug 2025 16:53:40 -0400
X-MC-Unique: R_27agvHM0WN-GsJvH5glg-1
X-Mimecast-MFC-AGG-ID: R_27agvHM0WN-GsJvH5glg_1755723220
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20B24188280A
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Aug 2025 20:53:40 +0000 (UTC)
Received: from localhost (unknown [10.22.88.234])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07BF03000198;
	Wed, 20 Aug 2025 20:53:38 +0000 (UTC)
Date: Wed, 20 Aug 2025 16:53:38 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: Crystal Wood <crwood@redhat.com>
Cc: williams@redhat.com, jkacur@redhat.com, linux-rt-users@vger.kernel.org, 
	oleg@redhat.com, shichen@redhat.com
Subject: Re: [PATCH] ssdd: mitigate tracee starvation
Message-ID: <2ovbfkvqsrho4qz6o3vxsjhju7x53va7mpughk6wr5gvjwgng7@zixf5fgbhken>
Reply-To: debarbos@redhat.com
References: <wljofbc7n4h6pav3tnvjgl6if7mdkkwep3uvja3etew2dyptbx@tyxiungtvg4r>
 <915bb279b1614baf860134e122de48ea6a5e2777.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <915bb279b1614baf860134e122de48ea6a5e2777.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Aug 20, 2025 at 03:18:17PM -0500, Crystal Wood wrote:
> On Wed, 2025-08-20 at 12:18 -0400, Derek Barbosa wrote:
> > When ssdd is invoked with nforks > 100 && niters == 10000 on a tuned,
> > realtime kernel, the following error messages can be seen:
> > 
> > forktest#4/8719: EXITING, ERROR: wait on PTRACE_SINGLESTEP #385: no SIGCHLD seen (signal count == 0), signo 5
> > forktest#1/8716: EXITING, ERROR: wait on PTRACE_SINGLESTEP #398: no SIGCHLD seen (signal count == 0), signo 5
> > forktest#6/8721: EXITING, ERROR: wait on PTRACE_SINGLESTEP #385: no SIGCHLD seen (signal count == 0), signo 5
> > forktest#10/8725: EXITING, ERROR: wait on PTRACE_SINGLESTEP #388: no SIGCHLD seen (signal count == 0), signo 5
> > forktest#11/8726: EXITING, ERROR: wait on PTRACE_SINGLESTEP #388: no SIGCHLD seen (signal count == 0), signo 5
> > forktest#12/8727: EXITING, ERROR: wait on PTRACE_SINGLESTEP #389: no SIGCHLD seen (signal count == 0), signo 5
> > forktest#14/8729: EXITING, ERROR: wait on PTRACE_SINGLESTEP #389: no SIGCHLD seen (signal count == 0), signo 5
> > forktest#15/8730: EXITING, ERROR: wait on PTRACE_SINGLESTEP #389: no SIGCHLD seen (signal count == 0), signo 5
> > 
> > This behavior is caused by ptrace_stop() being unable to sleep after taking
> > tasklist_lock().
> > 
> > As forktest() generates "niter" PTRACE_SINGLESTEP's for nforks, in the event
> > where nforks >= 100, the sporadic test failures caused by missing SIGCHLDs
> > indicates that the tracees are unable to effectively wait for their asynchronous
> > signals to arrive --as denoted in the previous sleeps for check_sigchld().
> > 
> > Therefore, by performing an addtional sleep() in check_sigchld(), we give the
> > tracee enough CPU time to call do_notify_parent_cldstop()->send_signal_locked().
> > 
> > The observed behavior after appling this patch mitigates the aforementioned
> > issue in scenarios with a high number of nforks.
> > 
> > Suggested-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Derek Barbosa <debarbos@redhat.com>
> > ---
> >  src/ssdd/ssdd.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
> > index 50f7424..7fdb039 100644
> > --- a/src/ssdd/ssdd.c
> > +++ b/src/ssdd/ssdd.c
> > @@ -145,6 +145,15 @@ static int check_sigchld(void)
> >  	for (i = 0; i < 10 && !got_sigchld; i++)
> >  		usleep(16000); /* 160 + 150 = 310 msecs */
> >  
> > +        /*
> > +         * In the _worst case scenario_ where the signal still
> > +         * has not arrived: the tracee is starved or
> > +	 * preempted, and needs more CPU time.
> > +         */
> > +        if(!got_sigchld){
> > +		sleep(1);
> > +	}
> 
> And then down the road we'll hit a load high enough that an extra second
> isn't enough...
> 

FWIW, the defaults listed in the source file have niters set to 10. The above
errors are more consistently drawn out when niters are actually >= 1000.

> How about replacing this whole thing with a call to sigtimedwait()? 
> Especially if the goal is to do the steps "as fast as possible".
> 
> -Crystal
> 

-- 
Derek <debarbos@redhat.com>

