From: Clark Williams <williams@redhat.com>
Subject: Patch to stop backtrace on 2.6.20-rt8
Date: Thu, 08 Mar 2007 17:22:09 -0600
Message-ID: <45F09AA1.3060909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:44525 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161107AbXCHXWM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Mar 2007 18:22:12 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l28NMAdN029290
	for <linux-rt-users@vger.kernel.org>; Thu, 8 Mar 2007 18:22:10 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo,

This patch fixes a backtrace I get when disconnecting USB storage
devices (well ok, my iPod :)):


diff --git a/mm/slab.c b/mm/slab.c
index 8761f4f..948007e 100644
- --- a/mm/slab.c
+++ b/mm/slab.c
@@ -4121,7 +4121,7 @@ static int enable_cpucache(struct kmem_cache *cachep)
 int drain_array(struct kmem_cache *cachep, struct kmem_list3 *l3,
                 struct array_cache *ac, int force, int node)
 {
- -       int this_cpu = smp_processor_id();
+       int this_cpu = raw_smp_processor_id();
        int tofree;

        if (!ac || !ac->avail)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFF8JqhHyuj/+TTEp0RAghfAKDnOZyOs8cusB4tulxTKtlI1wyrawCglEX3
GqENx7vnk9jrwD5w7WRfV2I=
=9qJX
-----END PGP SIGNATURE-----
