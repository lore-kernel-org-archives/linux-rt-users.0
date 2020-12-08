Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB105C4361B
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Dec 2020 23:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7484C23A22
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Dec 2020 23:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbgLHX10 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Dec 2020 18:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731729AbgLHX10 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Dec 2020 18:27:26 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E8C0613D6
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Dec 2020 15:26:45 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u18so754573lfd.9
        for <linux-rt-users@vger.kernel.org>; Tue, 08 Dec 2020 15:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UyyMs/oundYi4iw7+VRZ21wCa2Y/3Ei9nnkOvReF5i0=;
        b=izOsAMnNbCt3VEYvCAsuFPjfgWxcYaLddnsLDkaGqm3f0wWcCu3RTvF1F0efccLHFW
         VDJT1jWs4gRD/DuuWrHOSVuEfO1kAWNeOuS0lXzhYzZo8x8Px9i7+/NHhvlJ8iebgGP7
         h9nJv8rrMp0GUv0bvtE0OmV5j8KoqKTl55X0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UyyMs/oundYi4iw7+VRZ21wCa2Y/3Ei9nnkOvReF5i0=;
        b=UnX9ida4cjSH5Lox4T3mwBrTg3Gq8ScIP5xQ3hvfBsN599NlYuOvq/vf/uOeB/1eei
         xnjULtGYNQh4354bDGVd+TswykjLd9JJyIbcT8GwGtBIaJpW/gCjwJmELNvpQ6wHCa/e
         Kqs/N5DzV9MG3mZtIYvaXHh9Td/AthZRMkU+M7FsKpOcZMG82xCBGo9riDIux3oVtYks
         f5Zm05Y+oKzl+BOSh+YMOuNZzA130/mOuOzpkq2Tod4+y0ChyjUwpg3mhA8Z2QNvCWwz
         SzGMEpLwex9Na1Btd3juNyvSc+CL0MAkKYOJ1e7Xj/gR6Ftfi1p8BZSAdK9QhWCSvIfG
         KhKQ==
X-Gm-Message-State: AOAM533Nqb0ovCWLNb3ekj1luspzBMQVxdK4e8MryKgmQW5nbYn8pW6A
        xXI0M9cKhTlzL8WfAXTTdd42R3qITJIdRkvjHhI=
X-Google-Smtp-Source: ABdhPJwbLlzIPbOzSqekFi3STIJv9VdcUccVzE40tW+f/E8BeyF23pyzToEsRu1ZwFUvbU235FWpMw==
X-Received: by 2002:a19:f11e:: with SMTP id p30mr5783058lfh.395.1607470004123;
        Tue, 08 Dec 2020 15:26:44 -0800 (PST)
Received: from [192.168.10.101] (c83-250-124-157.bredband.comhem.se. [83.250.124.157])
        by smtp.gmail.com with ESMTPSA id m11sm31985lfl.5.2020.12.08.15.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 15:26:43 -0800 (PST)
Subject: Re: scheduling while atomic in z3fold
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
References: <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
 <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
 <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
 <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
 <20201130160327.ov32m4rapk4h432a@linutronix.de>
 <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
 <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
 <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
 <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
 <20201203133934.37aotbdjnd36lrxv@linutronix.de>
 <10d5088861ba219f3f7cd657fc95b0bedc19010a.camel@gmx.de>
 <cad7848c-7fd3-b4a4-c079-5896bb47ee49@konsulko.com>
 <3ffed6172820f2e8e821e1b8817dbd0bdd693c26.camel@gmx.de>
 <CAM4kBBL5+xNWq6DWHY6nQjwDTj8PZKem-rGuFvimi7jekjA+Xw@mail.gmail.com>
 <3ec93680c6a27626b23e99d552aa778be7b2ecec.camel@gmx.de>
 <CAM4kBBJ2jqBKdTPWPZEfuc17yiARMr_NwOSoHL_r0eC9n7UpUQ@mail.gmail.com>
 <9bd908b65ef15149458aa060c0daf065f9d45615.camel@gmx.de>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Message-ID: <159ce32b-a7c4-08be-9283-9e38a7c27848@konsulko.com>
Date:   Wed, 9 Dec 2020 00:26:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9bd908b65ef15149458aa060c0daf065f9d45615.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Mike,

On 2020-12-07 16:41, Mike Galbraith wrote:
> On Mon, 2020-12-07 at 16:21 +0100, Vitaly Wool wrote:
>> On Mon, Dec 7, 2020 at 1:34 PM Mike Galbraith <efault@gmx.de> wrote:
>>>
>>
>>> Unfortunately, that made zero difference.
>>
>> Okay, I suggest that you submit the patch that changes read_lock() to
>> write_lock() in __release_z3fold_page() and I'll ack it then.
>> I would like to rewrite the code so that write_lock is not necessary
>> there but I don't want to hold you back and it isn't likely that I'll
>> complete this today.
> 
> Nah, I'm in no rush... especially not to sign off on "Because the
> little voices in my head said this bit should look like that bit over
> yonder, and testing _seems_ to indicate they're right about that" :)
> 
> 	-Mike
> 

okay, thanks. Would this make things better:

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 18feaa0bc537..340c38a5ffac 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -303,10 +303,9 @@ static inline void put_z3fold_header(struct 
z3fold_header *zhdr)
  		z3fold_page_unlock(zhdr);
  }

-static inline void free_handle(unsigned long handle)
+static inline void free_handle(unsigned long handle, struct 
z3fold_header *zhdr)
  {
  	struct z3fold_buddy_slots *slots;
-	struct z3fold_header *zhdr;
  	int i;
  	bool is_free;

@@ -316,22 +315,13 @@ static inline void free_handle(unsigned long handle)
  	if (WARN_ON(*(unsigned long *)handle == 0))
  		return;

-	zhdr = handle_to_z3fold_header(handle);
  	slots = handle_to_slots(handle);
  	write_lock(&slots->lock);
  	*(unsigned long *)handle = 0;
-	if (zhdr->slots == slots) {
-		write_unlock(&slots->lock);
-		return; /* simple case, nothing else to do */
-	}
+	if (zhdr->slots != slots)
+		zhdr->foreign_handles--;

-	/* we are freeing a foreign handle if we are here */
-	zhdr->foreign_handles--;
  	is_free = true;
-	if (!test_bit(HANDLES_ORPHANED, &slots->pool)) {
-		write_unlock(&slots->lock);
-		return;
-	}
  	for (i = 0; i <= BUDDY_MASK; i++) {
  		if (slots->slot[i]) {
  			is_free = false;
@@ -343,6 +333,8 @@ static inline void free_handle(unsigned long handle)
  	if (is_free) {
  		struct z3fold_pool *pool = slots_to_pool(slots);

+		if (zhdr->slots == slots)
+			zhdr->slots = NULL;
  		kmem_cache_free(pool->c_handle, slots);
  	}
  }
@@ -525,8 +517,6 @@ static void __release_z3fold_page(struct 
z3fold_header *zhdr, bool locked)
  {
  	struct page *page = virt_to_page(zhdr);
  	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
-	bool is_free = true;
-	int i;

  	WARN_ON(!list_empty(&zhdr->buddy));
  	set_bit(PAGE_STALE, &page->private);
@@ -536,21 +526,6 @@ static void __release_z3fold_page(struct 
z3fold_header *zhdr, bool locked)
  		list_del_init(&page->lru);
  	spin_unlock(&pool->lock);

-	/* If there are no foreign handles, free the handles array */
-	read_lock(&zhdr->slots->lock);
-	for (i = 0; i <= BUDDY_MASK; i++) {
-		if (zhdr->slots->slot[i]) {
-			is_free = false;
-			break;
-		}
-	}
-	if (!is_free)
-		set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
-	read_unlock(&zhdr->slots->lock);
-
-	if (is_free)
-		kmem_cache_free(pool->c_handle, zhdr->slots);
-
  	if (locked)
  		z3fold_page_unlock(zhdr);

@@ -973,6 +948,9 @@ static inline struct z3fold_header 
*__z3fold_alloc(struct z3fold_pool *pool,
  		}
  	}

+	if (zhdr && !zhdr->slots)
+		zhdr->slots = alloc_slots(pool,
+					can_sleep ? GFP_NOIO : GFP_ATOMIC);
  	return zhdr;
  }

@@ -1270,7 +1248,7 @@ static void z3fold_free(struct z3fold_pool *pool, 
unsigned long handle)
  	}

  	if (!page_claimed)
-		free_handle(handle);
+		free_handle(handle, zhdr);
  	if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list)) {
  		atomic64_dec(&pool->pages_nr);
  		return;
@@ -1429,19 +1407,19 @@ static int z3fold_reclaim_page(struct 
z3fold_pool *pool, unsigned int retries)
  			ret = pool->ops->evict(pool, middle_handle);
  			if (ret)
  				goto next;
-			free_handle(middle_handle);
+			free_handle(middle_handle, zhdr);
  		}
  		if (first_handle) {
  			ret = pool->ops->evict(pool, first_handle);
  			if (ret)
  				goto next;
-			free_handle(first_handle);
+			free_handle(first_handle, zhdr);
  		}
  		if (last_handle) {
  			ret = pool->ops->evict(pool, last_handle);
  			if (ret)
  				goto next;
-			free_handle(last_handle);
+			free_handle(last_handle, zhdr);
  		}
  next:
  		if (test_bit(PAGE_HEADLESS, &page->private)) {

--

Best regards,
    Vitaly
