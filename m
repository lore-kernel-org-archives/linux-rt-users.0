Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D73C7EE2E
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 06:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjFAGkQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjFAGkN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 02:40:13 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 23:40:11 PDT
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E72133;
        Wed, 31 May 2023 23:40:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 38E05DE5F8;
        Thu,  1 Jun 2023 08:21:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1685600486; h=from:subject:date:message-id:to:mime-version:content-type;
        bh=twcsBfOjTDpVh6VIpSdBFhZaRFo+zWZG1bGrflkWktg=;
        b=HQbf85Edrn0Hf5mO8LxC3BoiiOAAI16XHr2BZse7yz6bZXLjYnU1Lyn58z2TC53Ldns2jX
        zPzHhypvbqa7th7CXrpfuoHNnVaX9wgvqN4ek8MTzIDcEoK2XcKa+iyfYLhAhmWX4a9cKa
        MCrFmL27xKQuYhY+cAFdBlX8VEZE1TNYYVvtCLhB5p89F9W9CgpLfTIhwAX6DzC6EuPvFb
        6ySIW28Ueb0XgoI2inJavdEJzxkid96WcX8ViNpE38WJMO6+42O0USJ+QoMMK+wWkPEq/O
        sCwerYWuWbcORGMX/KaWAzLul3tsopaj7x02ael5n+JC+O1chbNn1SpWg/gL0A==
Date:   Thu, 1 Jun 2023 08:21:18 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.283-rt124
Message-ID: <168560023269.6872.4317883590813798706@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.283-rt124 stable release.

This is just an updating to the 4.19.283 stable release, no RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 667d7f30ea873d10dc49365c95a387018da5961a

Or to build 4.19.283-rt124 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.283.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.283-rt124.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.280-rt123:
---

$ git diff 01355ace5b6eb7a7b153182438bb0667d682b284 v4.19.283 v4.19.280-rt123

diff --cc lib/debugobjects.c
index 5f23d896df55,e28481c402ae..e486693aea49
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@@ -421,55 -368,6 +421,55 @@@ static void debug_object_is_on_stack(vo
  	WARN_ON(1);
  }

 +static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket *b,
 +						struct debug_obj_descr *descr,
 +						bool onstack, bool alloc_ifstatic)
 +{
 +	struct debug_obj *obj = lookup_object(addr, b);
 +	enum debug_obj_state state = ODEBUG_STATE_NONE;
 +
 +	if (likely(obj))
 +		return obj;
 +
 +	/*
 +	 * debug_object_init() unconditionally allocates untracked
 +	 * objects. It does not matter whether it is a static object or
 +	 * not.
 +	 *
 +	 * debug_object_assert_init() and debug_object_activate() allow
 +	 * allocation only if the descriptor callback confirms that the
 +	 * object is static and considered initialized. For non-static
 +	 * objects the allocation needs to be done from the fixup callback.
 +	 */
 +	if (unlikely(alloc_ifstatic)) {
 +		if (!descr->is_static_object || !descr->is_static_object(addr))
 +			return ERR_PTR(-ENOENT);
 +		/* Statically allocated objects are considered initialized */
 +		state = ODEBUG_STATE_INIT;
 +	}
 +
 +	obj = alloc_object(addr, b, descr);
 +	if (likely(obj)) {
 +		obj->state = state;
 +		debug_object_is_on_stack(addr, onstack);
 +		return obj;
 +	}
 +
 +	/* Out of memory. Do the cleanup outside of the locked region */
 +	debug_objects_enabled = 0;
 +	return NULL;
 +}
 +
 +static void debug_objects_fill_pool(void)
 +{
 +	/*
 +	 * On RT enabled kernels the pool refill must happen in preemptible
 +	 * context:
 +	 */
- 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
++	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) || preemptible())
 +		fill_pool();
 +}
 +
  static void
  __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
  {
