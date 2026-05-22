Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F24219FE;
	Fri, 22 May 2026 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459197; cv=none; b=S11MOWtFcNRBYe4fcdRuG++9z+EuPrkJxeJ7NhkpKmsK66P67gMuON8qNR+ENUlkXYhtJQK5vYmpgKJDajMN5nVUc1utYLfCXTWkoVXzW97hBHQr377EJCb60EKrWXndnRXxrlNeO/lqeg8aiBhYODZB8DWZijxUMmm995lpdzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459197; c=relaxed/simple;
	bh=P1Td0JtmSEiSoYknYSjWjyc3BQH1jOIEFRqwp8Ne3us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAFMqwDMPmNlTPVzU/Bz4dPbE9TVyDSVUT6Q8Np5d9I78ipKRW4dUQ3jy/vEGO9Q5PGIzZK1RFW1K6SA/nXOqnSqB+xlXPrSEplGn+/SI5IuPTXthbBG32P9f6gDWRyR2CTtINZZGCc5UK47YIsmlrvBiBJ83hGuZd025UZHdX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=spyUvzJH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v1uL7mqx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="spyUvzJH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v1uL7mqx"
Date: Fri, 22 May 2026 16:13:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779459191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kRcJn9YloVOhkpTYAmHS3hG8yEnaixYAIlNNv+bW3yQ=;
	b=spyUvzJHuwjBr9mwwHWn3oBs0XzOj/pXGPVwLm6GQbh2kuzWqVSWiJeFzJGTTGVoqJgKkl
	qwVFG+wfRn10J21htcnQHmb8fs71pc+OoTYCXOZL3XA9jw3zqmBDrf6OE3XLLDx5QTDQAL
	dTM0bUkaELxipGsUuxfCd5acQlcw78IV7CwjQOXaGkht12z9qquKJXOk1iXdGhHLOlEmSj
	+p5XoIzqTPPpJvjW67usDfL0OGCQFwR2gTGEbc3HCvvoEV32dsFkqngZCsAmBBXtdSOX+f
	w7ztT0Z5OCCt7In5sOKSz8qyIWRpggyVlIfHk5adyejbD5xh0s89DO9xPw818A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779459191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kRcJn9YloVOhkpTYAmHS3hG8yEnaixYAIlNNv+bW3yQ=;
	b=v1uL7mqxFCTlT0qLsSGNBWpF1MrQaVGdgy+TSRqTZ5VMpqmGzlXXKdZ2dF2d4qbsuaRyTv
	fwikvQhpm1is4fAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michael Byczkowski <by@by-online.de>
Cc: Rodolfo Giometti <giometti@enneenne.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v5 0/3] pps: improve PREEMPT_RT performance
Message-ID: <20260522141310.4gjpozvo@linutronix.de>
References: <719A31CE-CA58-45C3-A013-1BFE81F724C5@by-online.de>
 <5FDC46CF-4F8F-4E85-9E59-B796C5BF1194@by-online.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5FDC46CF-4F8F-4E85-9E59-B796C5BF1194@by-online.de>

On 2026-05-16 13:32:03 [+0200], Michael Byczkowski wrote:
> Gentle ping on this series. v4 patches 1/3 and 3/3 carried Rodolfo's Acked-by; v5 addressed the remaining feedback on 2/3. Happy to rework anything or split the series if that helps it move forward.
> 
> Adding linux-rt-users@ and Sebastian on Cc in case there's interest from the PREEMPT_RT side.

Was there a follow-up to the series?

Sebastian
