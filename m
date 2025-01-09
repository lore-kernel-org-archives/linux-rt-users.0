Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCAA1FCFF4;
	Thu,  9 Jan 2025 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417498; cv=none; b=mXtZFBuYn37xMlsurBgYx7M70J/7Bpg2ZhRYzhxbpKxlWS9rZxOrtRvqS+hctfabfgWBUStx1zl7on5FXHeNlaJ3JxbxSlY13cQgbB8xluDx3wCNqKATSb4CkrvGuS2/EhRuljRCz9NlcSQeaoPyzJlDbxr4r0QGwLndjdt8O/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417498; c=relaxed/simple;
	bh=VY3waFc3QsqqVOjn+0pJXXc0h0YRwAo6/oRgh/vOkP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kARhvcbjtYrweqymbXhSBfewt7s+XWpkjOw5JMRzTEwHILlkc32uYJrTcoyQ5Pcb2Pi295410uwecbzU72swjhYBVjwnx6KzlDWPISJB5NupgnqRkYj6EitqXfTZo4LUVZKHHGOaK1fanujZnGL/HBfFq5ZebEvIcfx5On0S/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h6KMGJ9O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hl4zjEZN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h6KMGJ9O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hl4zjEZN"
Date: Thu, 9 Jan 2025 11:11:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736417495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTEHeGcSL5ZHkWRPY4ERD0o2U5+jD0Nv8pvCPq13Cgw=;
	b=h6KMGJ9OFUgmWNSWx8iW2tqUSX9ODPHCLVomyQCYGu+Ynt8CpxWvINMQaNTFvxOkLnAxgG
	pPUXb26wbS6JBNbXCszijMN3vlJyf5sLU/RcWZQGCdZS9/pMz7TrUt1L6a+47YLX+iBgjs
	qMuRThEUaXidFQIcJfmiC2VQjEGiLkODE9OA2sQ6yh5BOVq/UAaggt9hf45PQjwqptt2Gk
	1knVZ5AJOyOOAwMRJhPcJiCNNJrQW+TGo8JmoroXeRHdTBghbvVQSFo5IdnJICnMi7vg3t
	YDMa/MMD36JRBST0T3/DuoKzndxlVdJ6kmhIjniZxK6syyffbOaDOlAITWHagQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736417495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTEHeGcSL5ZHkWRPY4ERD0o2U5+jD0Nv8pvCPq13Cgw=;
	b=hl4zjEZNAWC4Gn7oWBQUCrp+sSDK8nZDrnc1GbZnYZ/mBcnFvDYdgusQ8gyiEBbGjDJMZH
	HpsOmysU7WdP4NCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v6.13-rc1-rt1
Message-ID: <20250109101133.c7rK5UDy@linutronix.de>
References: <20241206154701.8XBv1qNE@linutronix.de>
 <20241216165248.5cae6311@mordecai.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216165248.5cae6311@mordecai.tesarici.cz>

On 2024-12-16 16:52:48 [+0100], Petr Tesarik wrote:
> Hi Sebastian,
Hi,

> 
> However, I found 26 patches in v6.13-rc1-rt1-patches:
> 
> petr@mordecai:~/src/linux>  git ls-tree v6.13-rc1-rt1-patches:patches | grep '\.patch$' | wc -l
> 26
> 
> It turns out, that these two patch files are orphaned (not listed in
> series):
> - netfilter-nft_counter-Use-u64_stats_t-for-statistic.patch
> - riscv-add-PREEMPT_AUTO-support.patch
> 
> What is the reason to keep them around? Is it even intentional?

Nope. I forgot to delete them after I removed them from the series file.
Both were applied upstream. I just dropped them from the recent -rt3
release. Thanks for the note.

> Petr T

Sebastian
