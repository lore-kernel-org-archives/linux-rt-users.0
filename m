Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62441C62
	for <linux-rt-users@vger.kernel.org>; Fri,  1 Aug 2025 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053033; cv=none; b=ohrxmKGSY5u4bEF2BmonjmeqUqXIdktgYEfD5Nt3hG1RWDBs1VvJu4d5Yob6NaXhdMj8RCLaaE3lzq9EqYgXU9RU+2P91USvrG8C7K9wzKSImVkwn/qcAyOScRD9Bf/ya6GotnVP7F1M+nYxvbjGtDTyFfmFFiPSchVV5rXQ/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053033; c=relaxed/simple;
	bh=LqTgMO8PQ0IGc9FI51uzqbmQtJQTBxSSKp34m1bOQLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/A0MgfOjHHCTcRrXLJAPA2xngtwCnzqi1qfdc46sP3MuGyiWYemFyKIpTiuIo5sC8YsszmK4z78jIZUcH6M7tFa1QwsM/lAhd6k2Ej/TSf7gdRAVTluYq3mGf8BglVg4wCntf1DfaMr7ybQQz0yb/NVplqBbG12+S7DvAwyh9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l6Fil9/c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8tYGTVVJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l6Fil9/c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8tYGTVVJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l6Fil9/c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8tYGTVVJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l6Fil9/c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8tYGTVVJ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A2A691F7ED;
	Fri,  1 Aug 2025 12:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754053028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e+he1+kKKz0LSF03sq2WnJU/BlUAAvBXA99h2cauoms=;
	b=l6Fil9/cfa3HAzy9Tx+CAe2iI2+rzq2l+0oFEu5702nfbxmQtieUrXcFe2HKzkmGf8YAHj
	wbddiJvcORR1FmkABEE5DG7KdRzJjwht5fvd5xQimZ4xNHHhIFQ02ktTkzbh8AulM1cY/X
	9SJLbsIgXbL9SjngUCgGdKTDJgmvkMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754053028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e+he1+kKKz0LSF03sq2WnJU/BlUAAvBXA99h2cauoms=;
	b=8tYGTVVJQcEmnE9I9h+raiZy5/IcgpXbhI1n72DRiOcASnlkPGW1Om8w7KSxxPrAk3LUhb
	ss5TfJBA8tbBGhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754053028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e+he1+kKKz0LSF03sq2WnJU/BlUAAvBXA99h2cauoms=;
	b=l6Fil9/cfa3HAzy9Tx+CAe2iI2+rzq2l+0oFEu5702nfbxmQtieUrXcFe2HKzkmGf8YAHj
	wbddiJvcORR1FmkABEE5DG7KdRzJjwht5fvd5xQimZ4xNHHhIFQ02ktTkzbh8AulM1cY/X
	9SJLbsIgXbL9SjngUCgGdKTDJgmvkMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754053028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e+he1+kKKz0LSF03sq2WnJU/BlUAAvBXA99h2cauoms=;
	b=8tYGTVVJQcEmnE9I9h+raiZy5/IcgpXbhI1n72DRiOcASnlkPGW1Om8w7KSxxPrAk3LUhb
	ss5TfJBA8tbBGhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9164713876;
	Fri,  1 Aug 2025 12:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IXO0IaS5jGiKfQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 01 Aug 2025 12:57:08 +0000
Message-ID: <c48f2877-4d37-4310-995e-fc5c2ae9a366@suse.cz>
Date: Fri, 1 Aug 2025 14:57:08 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Realtime threads delayed due to kcompactd0
Content-Language: en-US
To: Alexander Krabler <Alexander.Krabler@kuka.com>,
 Mike Galbraith <efault@gmx.de>, Frank van der Linden <fvdl@google.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Dennis Schimmel <Dennis.Schimmel@kuka.com>,
 Daniel Braunwarth <Daniel.Braunwarth@kuka.com>
References: <DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
 <CAPTztWYf82p6hq=Q2mVq6_9WTjRaQiH81z4idZL6MZ1PXufPwQ@mail.gmail.com>
 <71df781c-3ef3-4b26-9ba8-93fc7d4f9eec@suse.cz>
 <026de9fcd4f0ed17c2df95c4f7c56b878a844012.camel@gmx.de>
 <25ba0d77-eb61-4efc-b2fc-73878cbd85c1@suse.cz>
 <DU0PR01MB103857873A56FD121984568148226A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <DU0PR01MB103857873A56FD121984568148226A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kuka.com,gmx.de,google.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 8/1/25 13:23, Alexander Krabler wrote:
> On 7/31/25 20:35, Frank van der Linden wrote:
>> Not sure what the right thing to do would be. Either explicitly boost
>> the priority of a thread temporarily during migrate_pages_batch, or
>> mitigate the issue by dealing with 'busy' pages more quickly in
>> migrate_pages_batch.
>>
>> - Frank
> 
> I think it would help if priority inheritance would kick in as soon as
> another thread is waiting due to the migration PTE.
> 
> 
> On 8/1/25 11:58, Vlastimil Babka wrote:
>> On 8/1/25 04:46, Mike Galbraith wrote:
>> > On Thu, 2025-07-31 at 20:41 +0200, Vlastimil Babka wrote:
>> >> On 7/31/25 20:34, Frank van der Linden wrote:
>> >> > Not sure what the right thing to do would be. Either explicitly boost
>> >> > the priority of a thread temporarily during migrate_pages_batch, or
>> >> > mitigate the issue by dealing with 'busy' pages more quickly in
>> >> > migrate_pages_batch.
>> >>
>> >> There's a workaround for realtime tasks. If you mlock[all]() their memory,
>> >> setting sysctl vm.compact_unevictable_allowed to 0 should exclude these
>> >> pages from migration by compaction.
>> >
>> > Hm, per documentation that's done automatically for PREEMPT_RT...
>>
>> Oh I see.
> 
> Yes, vm.compact_unevictable_allowed is set to 0 in our setup
> (default as we have CONFIG_PREEMPT_RT).
> 
>> > On CONFIG_PREEMPT_RT the default value is 0 in order to avoid a page fault, due
>> > to compaction, which would block the task from becoming active until the fault
>> > is resolved.
>>
>> So it's probably the mlock() part missing since that should otherwise apply
>> to kcompactd.
> 
> We use mlockall() and I verified the pages have the lo flag set.
> Which means, that we have exactly the issue this sysctl flag should prevent us from.

Hm that means something isn't working as intended. Do the pages have also
the unevictable flag?
>>
>> > ...but rummaging, seems other stuff can step on it (contiguous alloc?).
>>
>> Yeah, there was time CMA was just something for mobile phone hardware. As
>> usage increases beyond that maybe we'll have to tackle it. Ideally by not
>> having mlock'd pages in CMA areas at all. And if contiguous alloc is
>> attempted outside of CMA areas, respect the sysctl there too.
> 
> Yeah, we already thought CMA might somehow influcence our issue.
> We have 256 MiB of CMA, which our hardware probably uses.

If the problem is kcompactd, it should not be CMA related.
> Is there a way to tell a process to not allocate pages inside CMA area?

I think not at the moment.

