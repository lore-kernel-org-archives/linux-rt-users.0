Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD0A2874F1
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Nov 2025 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875368; cv=none; b=biEd5ejfHLzqz04CLvY/xqqcJWMRNNtByYA4tbP9BSfZj5TmVrIdOfCmG0x7QJeiLdAHYTDgxoAI5Z7g94Q1RDGLkAmfGbmPIb2lk8X87lLTL6EABanruzVuYc/a64+HJUU1OuS85jeR6M1hObx7f+79VaNWW+8H8Zs3CIAQSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875368; c=relaxed/simple;
	bh=ZEpaC8OZOO3c0XwDXOuijFWQ0U1fbgw5vtzqhxDmr64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Be7F9vmaOr3wmukuC+fjc+WXPFh/rW7dSf1k2mxHkFJFyftVfBl6Bez1k5/mELFHYblS+toXhrCSUHrUhPxHfCWWvF3a9859szIONyBR7eY1kwuJf3cZutxIfq8XBzxnNVMy7HNrIwl9TNiLV2r3h6tnoVTlbxt6lC5lukqiYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgcaxXU+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgcaxXU+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762875364;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=V6msyD+5DDTHNzDNON3SRRq2DGvRUlct/hEx2n4C0Ao=;
	b=HgcaxXU+SKSGb7O7OLfRA82kFEwj8tC7FvsUaLjXM+zAbQsPjxpprWqC/OSEv4srtJWqWw
	iRT7zduzNegVSNqMM8f5LdwBHFE7KhBlkrgZ7sT+ym6c/3AVNu5CziFWLsnxUo5qqr/2MC
	jTfGUFJGWqwZAghoN3grkztkWXLdk7c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-pXZ2PyWtPO2kw8l5KtP1aA-1; Tue,
 11 Nov 2025 10:36:01 -0500
X-MC-Unique: pXZ2PyWtPO2kw8l5KtP1aA-1
X-Mimecast-MFC-AGG-ID: pXZ2PyWtPO2kw8l5KtP1aA_1762875360
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E3C21954B0A;
	Tue, 11 Nov 2025 15:36:00 +0000 (UTC)
Received: from localhost (unknown [10.22.80.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B180430044E7;
	Tue, 11 Nov 2025 15:35:59 +0000 (UTC)
Date: Tue, 11 Nov 2025 10:35:58 -0500
From: Derek Barbosa <debarbos@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Wander Lairson Costa <wander@redhat.com>, williams@redhat.com, 
	linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/3] Improve Makefile robustness and explicitness
Message-ID: <dgm5dmxmq56rtcorzcapb6ibzlch73xwqfavwtbzrbpi6ukfgv@h32wjmfahkfm>
Reply-To: debarbos@redhat.com
References: <20251107161729.320087-1-wander@redhat.com>
 <20251111145020.C7DI111V@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111145020.C7DI111V@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Nov 11, 2025 at 03:50:20PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-07 13:17:25 [-0300], Wander Lairson Costa wrote:
> > The first two patches add checks to conditionally use compiler flags
> > -mno-omit-leaf-frame-pointer and -fcf-protection, preventing build
> > failures on systems where they are not supported.
> 
> I don't know what this part of but shouldn't the Makefile just consume
> what the buildsystem provided and not randomly strip CFLAGS?
> 
> Sebastian
> 

Hey Sebastian,

Part of the changes were to keep in line with what Daniel had in the makefile
originally, and just doing some hacks to ensure that these flags are
conditionally included based on arch support.

In the case of -fcf-protection, Clark and I noticed that if a particular host
system was using, say, the sched debug file as a parsing logic "backend" by
specifying it in the command line, it was most likely because the system does
not have BTF support enabled.

We were particularly worried about much older systems with older compiler
versions, which would prevent them from compiling stalld from source if they
desired to use this legacy interface.

Not sure if this answers your question at all. Sorry for the rant.

-- 
Derek <debarbos@redhat.com>

