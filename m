Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDC21772B
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Mar 2025 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450939; cv=none; b=P6Dm44BPd7UttMeFCEL266Pim3S19wfY4eOwGA8Ys11uTX+CvYVAQlZkBhlmN8PedMXG7CXkYxEYFojWyH2abpJ7wkNIfdi9WMQ1792sfyYDCWDOJAiH+t1EMM8K/5CKxQB7/yM+r3+Ej7phKzFcRf2yWzOGpciEcVPAY9wpSOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450939; c=relaxed/simple;
	bh=/SV3Ue8RT8R1pk4nuuy3CCq8rg3CK3wnZYlzWaB26n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7gn81ZkpVbXFQuwTe8BfSJab2nlYvJGD6AGrShOUYgqRomrwws5432PZPnIRLzgkNslMdKzPA1rusfd7MD13LnYs6q/OUAx5U8Q9bMHUzr1vs2yVtnWVySGJee8il7duufXEFJEQshzZLVYEo15hYLAyCsvHz8D7ptO2h6Zzqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYG9ei1b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYG9ei1b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743450936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PO5PrD44xfap3+sRbTDqtqjtqcFMzH1d7geKnSWPw7k=;
	b=fYG9ei1bujPn1eQsU82dRqMGbFmTBjYc/NT+geP92fvb6NLPaULPv6khV3R1ChnVGnvHpB
	Fth0oSzpD0S+6buctkxXY295SpCs+No6Hw53SCGOSVUmKJcTVONXk/HR85MxnoxAl8ELrm
	kIVmghwMH/6r0eKnmfO7LCIpiqzCryM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-mam6GU1SMMy69vAx0VlUiQ-1; Mon,
 31 Mar 2025 15:55:32 -0400
X-MC-Unique: mam6GU1SMMy69vAx0VlUiQ-1
X-Mimecast-MFC-AGG-ID: mam6GU1SMMy69vAx0VlUiQ_1743450931
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 071791800349;
	Mon, 31 Mar 2025 19:55:31 +0000 (UTC)
Received: from localhost (unknown [10.22.65.234])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79742180174E;
	Mon, 31 Mar 2025 19:55:30 +0000 (UTC)
Date: Mon, 31 Mar 2025 16:55:28 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ben Hutchings <benh@debian.org>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 5.10] rt: Fix buid issue in be2net
Message-ID: <Z-rzMAX8mQrAu7_5@uudg.org>
References: <Z-cGnAlIvThsPiH8@decadent.org.uk>
 <20250331093844.B9DjnmBS@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250331093844.B9DjnmBS@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Mar 31, 2025 at 11:38:44AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-03-28 21:29:16 [+0100], Ben Hutchings wrote:
> > The problem described here is specific to v5.10-rt.
> …
> 
> Thank you for the report.
> 
> Luis is aware of it and handling it
> 	https://lore.kernel.org/all/Z9yuIpi8zjrTCkoB@uudg.org/

Thank you for the report and patch Ben!

As Sebastian mentioned, I was working on that and looking for input from
the other RT maintainers on whether to fix that case with a small patch or
backport the lock primitive definitions from, say, v5.15-rt and remove the
two patches we have in place for similar problems.

As, so far, the usage of similar statements has been rare in the code, a
small patch sounded like a good compromise. If another update brings a
similar statement (void function returning <spin_lock macro>), I will
backport newer locking primitives (that use functions instead of macros).

Best regards,
Luis

> 
> Sebastian
> 
---end quoted text---

