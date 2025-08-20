Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651F623ED75
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Aug 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700165; cv=none; b=ATITEF/pf9XKbPZ3mYaciTBaOO7oDupOY55K8COBQoLuYJOwMEJTau9E18Q7u3RohSOAVmKkvpzACQjcA4FrrmJMl9xkI9VBaGLVM3ZrIdbxRIeqDfcn0ScnL60jYU5uSHMLNlIEcnfm7I0/m9Ug6a8r8DdOepI7MEcPfQLsKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700165; c=relaxed/simple;
	bh=a4thEGY7t2Ebr0cfXIZ9XanDPfm973C5EqY78k0FlIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/YSdoKGLZdZZdrqmKVLdK1UKFzfX/4Ju+lNzyOZX+Tg8vYu1+f8V2ePe6JVElRjWX5glcC0NdkEwIsIOSK+tI5tSujhac1y9VMPoVKSLdEtu5BS56NrDAJ4oHuu6FPcsiGFDIWPFE30tdI4dYPrHxjaVeBjoy5u6mfuaDiFjqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kiDI7Vli; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GX6oukrz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kiDI7Vli";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GX6oukrz"
Date: Wed, 20 Aug 2025 16:29:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755700161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0R9AQPmRbYMvwJGQyRIbyAyWRhXxzoL6fzlgh2yodPw=;
	b=kiDI7VlipbXXRaLgH6llw4hWvYZTSC0MYIHjxPF9zn0IvqSu0nrVhUpfqPpwuB+arQ9H8T
	qu97srbNgSLoa9NmKR3Hng7Z1iyNUdZRQjAFAkCqr4KNhGAhOOflvm4lFInNcRSrHy8caY
	iGeLUCQK+/BAzAguAn1UdUqaKzp3sttj5t+fFTeN0Xu4r5cLwhWGgjGRAxmklWAAFWfrLG
	A/ShHeEf/ZyKeMSi0kH538TnLjzhHcEBjMSSXnB+WESut09CXlpFb4R4YcXLvnqj+Po2gR
	voJYYYgovR6U9WXYNta4fqVhkRXG4GR4kAhsx4GG3vgVT9gLvsyJQlp11Bov2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755700161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0R9AQPmRbYMvwJGQyRIbyAyWRhXxzoL6fzlgh2yodPw=;
	b=GX6oukrz3GoLun30KHSeZSUOQ5ufHTWdFAU1fEFVzDePZtuPJyFIz7+lwJrcYXwUUBkRP0
	wP/QPnUwsAlMVgCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexander Krabler <Alexander.Krabler@kuka.com>,
	Hugh Dickins <hughd@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Mike Galbraith <efault@gmx.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Dennis Schimmel <Dennis.Schimmel@kuka.com>,
	Daniel Braunwarth <Daniel.Braunwarth@kuka.com>
Subject: Re: Realtime threads delayed due to kcompactd0
Message-ID: <20250820142919.HTybedrl@linutronix.de>
References: <71df781c-3ef3-4b26-9ba8-93fc7d4f9eec@suse.cz>
 <026de9fcd4f0ed17c2df95c4f7c56b878a844012.camel@gmx.de>
 <25ba0d77-eb61-4efc-b2fc-73878cbd85c1@suse.cz>
 <DU0PR01MB103857873A56FD121984568148226A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
 <c48f2877-4d37-4310-995e-fc5c2ae9a366@suse.cz>
 <DU0PR01MB10385C08C119276D99A234D978226A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
 <33275585-f2db-4779-89f0-3ae24b455a67@suse.cz>
 <771a8fc0-8195-44cc-55ed-c3573d497d2d@google.com>
 <DU0PR01MB10385C55AEAFEBCA2575EAA77822CA@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
 <c5bd00d6-e6ca-48fd-a11e-c90fa9c50e05@suse.cz>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5bd00d6-e6ca-48fd-a11e-c90fa9c50e05@suse.cz>

On 2025-08-08 09:37:26 [+0200], Vlastimil Babka wrote:
> > Given the information I got from here, the comment on the code [1]
> > and an older commit message [2], I suspect CMA somehow influences our problem.
> 
> However, kcompactd doesn't perform CMA allocations, only compaction, in a
> mode that does not include ISOLATE_UNEVICTABLE. So this is weird.

As per smaps, the RT task should have all VMAs listed as "lo". If use
mlock() then something like an accidental fork() would remove it.
Otherwise it should be there.

At the time of the fault you could add something like

| diff --git a/mm/memory.c b/mm/memory.c
| --- a/mm/memory.c
| +++ b/mm/memory.c
| @@ -4476,6 +4476,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
|         entry = pte_to_swp_entry(vmf->orig_pte);
|         if (unlikely(non_swap_entry(entry))) {
|                 if (is_migration_entry(entry)) {
| +
| +                       if (!strcmp("tRealtime", current->comm)) {
| +                               trace_printk("Migrated: 0x%lx VMA flags: %lx\n",
| +                                            vmf->address, vma->vm_flags);
| +                       }
| +
|                         migration_entry_wait(vma->vm_mm, vmf->pmd,
|                                              vmf->address);
|                 } else if (is_device_exclusive_entry(entry)) {

to see address is gone. Not sure if the PTE flags are of any help here.
Is it easily possible on the other side (isolate_migratepages(), right?)
to figure out which task a certain address space/ page belongs to? So
would if a "bad" page is considered for migration.

Sebastian
