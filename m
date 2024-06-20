Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B31BD006
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908462; cv=none; b=TTFdMCebxCxYgiklZzywxY2k7mr+rBcMg0d/wfNIuIGrdqbQRve38QR+hOC4DYynQmmwcdsBvgzT7LwKYFXc9LNAMe6siPV7vBjv74yZbXKCPSrUoZaUtXvbnci94RH4lbFuV+XZ7vU3Gg0rRyegpRDqIXKrKIiiBR28CiXcGdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908462; c=relaxed/simple;
	bh=SLTcb+k51rqswflzWg3ZbykIc839nIpu4j+u+uc48KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyUr1XgLv7X1Vul1vx4ACjE+379K4vJANZ+2u11Q3UJUsGTyYKU73tYvRP+yz+Gpo8nX/7cd8ZPP5EY1AMXA/TA6iOGcn5r/0YKODah15zTRMNo2u/Nb0qT698Iy0EbxvODOFOdQd/ZfJ9QBGmkZ7J436rVbI27yypY6Oe/6kw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duycs5in; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duycs5in"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718908458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lWGOZ5x9U68yB64FGPI0opjFJHzrTVmGdyjMtfdZyeU=;
	b=duycs5inRjrbO+QCIUd2AUJolRTWT5PykqxykINFlQ0UoxSUNyZ5D1RymoejXo8ulzf2Gw
	Vi8a/eoCzCOkeN/oDwCQf49dIHgLTq+aG9+Z1Npif0o29axP8W1O1TqgQNRngzKM6AQK6o
	US6jMHKAK8qnJwHMAEZY0+tN4yEkV4c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-CMeDcwWLP_GcYKQq1Ny3eA-1; Thu,
 20 Jun 2024 14:34:15 -0400
X-MC-Unique: CMeDcwWLP_GcYKQq1Ny3eA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B30081955D5B;
	Thu, 20 Jun 2024 18:34:13 +0000 (UTC)
Received: from debarbos-thinkpadt14sgen2i.remote.csb (unknown [10.22.10.164])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87F7B1956048;
	Thu, 20 Jun 2024 18:34:10 +0000 (UTC)
Date: Thu, 20 Jun 2024 14:34:07 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	john.ogness@linutronix.de, pmladek@suse.com, rostedt@goodmis.org,
	senozhatsky@chromium.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, williams@redhat.com,
	jlelli@redhat.com, lgoncalv@redhat.com, jwyatt@redhat.com,
	aubaker@redhat.com
Subject: Re: [PATCH] prinkt/nbcon: Add a scheduling point to
 nbcon_kthread_func().
Message-ID: <ZnR2H5l7hyQflA4E@debarbos-thinkpadt14sgen2i.remote.csb>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
 <20240620071545.Es9LoyJY@linutronix.de>
 <20240620093246.HE9XDWSZ@linutronix.de>
 <20240620094300.YJlW043f@linutronix.de>
 <skr5kyam73ldikhn7uc6b3ikq4cxrtd4ohd4dekkhlmtyxmnbg@mw6xlvaop6hz>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <skr5kyam73ldikhn7uc6b3ikq4cxrtd4ohd4dekkhlmtyxmnbg@mw6xlvaop6hz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jun 20, 2024 at 12:18:37PM -0500, Andrew Halaney wrote:
> Acked-by: Andrew Halaney <ahalaney@redhat.com>
> Tested-by: Andrew Halaney <ahalaney@redhat.com>
> 
> This survived a bunch of tests that normally would cause some lockups
> etc in PREEMPT_VOLUNTARY systems. I can see that the nbcon thread successfully
> migrated NUMA nodes etc during periods of overwhelming the console backlog
> successfully, which without this would not work prior.
> 
> Thanks!

I'm going to second Andrew's observed results here. With the original
reproducer of calling LTP pty03 && pty06 in a while loop, plus invoking
stress-ng with --timeout 60000s && --numa 64, there were no problems with the
nbcon thread migrating NUMA nodes and no panic(s) with 
kernel.softlockup_panic = 1

This was observed on an nproc == 128 machine.

Thanks! :-) 

Acked-by: Derek Barbosa <debarbos@redhat.com>
Tested-by: Derek Barbosa <debarbos@redhat.com>

