Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481CD215051;
	Thu,  9 Jan 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412126; cv=none; b=JaNQmHLU7hEeXZT0E+P1JtBMfTVZLCuZ6X9jwYXnoV4gbVdXXmSXnPfM5zBDXp08f6LnsQ1Qh26YggKHpsGi3MuOryhJXDfk7DEUFiLiUnI/pE67LAWyJ8iTa0apCxPDpbko8eCw+BXb3yvjdQXEjaUE6xOESloc59IJKyYJguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412126; c=relaxed/simple;
	bh=lIExu1+mqud5aFROnKe3lpewKfZw+pyDw7Q5chPEnKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cbw+NtUpXE6x5+3UOC+gz/1znKj1mxufJ5wU2wPnheOfRErcypEOTB/qxeXcr22io2GRgjBpmTX2b2OLi6jvLG16rc1xOGBVXY2Y2+WpUlM5qM71DDNRhJJivU7nUcXJXDMfNbh2KP7mOEnVX2/Y5biGhwDIpp0Nug4kpv+9X4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=c3AJxysG; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="c3AJxysG"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 669F51484E5B;
	Thu,  9 Jan 2025 09:35:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1736411722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4QbobkL/IsJcR2v57oNKdG88iAe5/cIdPqkEqSLI2A=;
	b=c3AJxysGFQqy7sWqzuZ1N4go0DyM83F3ILV0ifSSuSLY4RmAdLL7wzMnmfar0dFEmlwKoL
	aKoOPU6QHP/PJX8OfumlIvMxlvpenYKvk8NH63YM9frxkCVffVqEg3pWcAoH6u6b4MvCFI
	K0EgAqqqoTtAXmpT1MC2YweTexf08c1o6N2zfTJjht47n28RqdLVGvVsgExsVO8i9eCbQa
	u+Dxn3m2OZnxNd5WaRFUuRLC5LjNl6PwFU31cHfJOVbRQ3Sg6xmFlHUZlbWD5+4YtnItlf
	d2bJ/XHNQejKAJ/sAi/6R5JO55DPbWle6lIHu2QY1isNjJdBLM4bMMVWggZAvQ==
Date: Thu, 9 Jan 2025 09:35:20 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Christian Eggers <ceggers@arri.de>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RT] v6.12-rt stable branch?
Message-ID: <20250109-sensation-diabetic-9b082008c6d4@thorsis.com>
Mail-Followup-To: Christian Eggers <ceggers@arri.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2732654.vuYhMxLoTh@n9w6sw14>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2732654.vuYhMxLoTh@n9w6sw14>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hei hei,

Am Thu, Jan 09, 2025 at 09:23:23AM +0100 schrieb Christian Eggers:
> Although most of the remaining RT stuff has been merged into linux-6.12, there
> seems to be still no out-of-the box support for RT on ARM 32 bit platforms.

This is also how I understood it.

> Are there any plans to release (and maintain) a v6.12-rt stable branch? Or shall
> I pickup the necessary patches into my local branch myself?

We have some systems with Microchip AT91 SoCs (SAMA5D2, SAM9X60) and I
would be interested in those patches as well.  The last patch
published was 6.12-rc4-rt6 from october.

Greets
Alex
