Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680323B604;
	Fri, 24 Oct 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317682; cv=none; b=BGYBAl6B51qT7a/3/J9tL4TrZLtfOb0rvSU3Uy0hK0EWxNmHBhgPXY4bjwvC+Apzu/kPbP5i3bvkpX3Ari7D4l0RQqusKjjAoRojrecGcmwxW5okI/xqdYKKRS0SMD1cpRIvng/e7CK4Hoa0yHWhLLmOrCfmnVyjz9Yn6SjR44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317682; c=relaxed/simple;
	bh=7IhR2vSj/blV12vbTgFp/+60dHurur0StmZegWMD0Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tSnM0GOKjEi+H4tgl+Tq5+XXesclJU34fpheKvLdD6lsOBOJSqDJnHj4pHSBGF1KVONKIvCEe42strK7hFU3RWLPDeSqLTvz+PRA1QK/jOrif5O+CG/cyiD8JFkTj57bhZQK1d4hCqLMRR8HTVcaeyh+sY+J9uNo3+fz7ehZ1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BrBGXayH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7pTkKdAy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BrBGXayH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7pTkKdAy"
Date: Fri, 24 Oct 2025 16:54:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761317678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=HWVNNi74jWPH4NGKAmlxWJhUNoDFgbuFi3sJhS766a8=;
	b=BrBGXayH2dTNR7WQgaIFDXC9VmS2mG339Y5ODwtFWsIt5uPn2vltX8PnqbSe9S92VrNfjC
	D44hrSkMx9S7TVQoLcP2laUFEXsmeryBaagalT3v7Fy+Yy91Ir0GmXhKUZD5dNxqMweEoT
	yxB5i5nDFtkPirQCBgxZV0wBQeaphYAEGgCMxXPJGqmhGRhFAoR7EOK+OQg2YxCOxcPtZY
	SbvygQAs94G2OzFnvikthPoYhKtwlL7CgIikHeKQroF8MT0MuTn4u+guMYxcKv5rpGvynB
	GuHQA1trZ+t4shYGbJ7T7aVZcOqRHe/xIoHvDBX/joToEr625GUZDJDvI8b8Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761317678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=HWVNNi74jWPH4NGKAmlxWJhUNoDFgbuFi3sJhS766a8=;
	b=7pTkKdAyKJvy6e0v8Xt9jnERt9nm0ZX/YEkecGrPJIz2+dFpplLfHissGOwA2Hm1eBzjlg
	YEvYIYLdriqIPeBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.17.5-rt7
Message-ID: <20251024145436.souGwBdZ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.17.5-rt7 patch set. 

Changes since v6.17.5-rt6:

  - The previously introduced gro-cells related suffered from a missing
    unlock. Patch by Eric Dumazet.

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

The delta patch against v6.17.5-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.17/incr/patch-6.17.5-rt6-rt7.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.17.5-rt7

The RT patch against v6.17.5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.17/older/patch-6.17.5-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.17/older/patches-6.17.5-rt7.tar.xz

Sebastian

diff --git a/localversion-rt b/localversion-rt
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index b43911562f4d1..fd57b845de333 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -43,12 +43,11 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 	if (skb_queue_len(&cell->napi_skbs) == 1)
 		napi_schedule(&cell->napi);
 
-	if (have_bh_lock)
-		local_unlock_nested_bh(&gcells->cells->bh_lock);
-
 	res = NET_RX_SUCCESS;
 
 unlock:
+	if (have_bh_lock)
+		local_unlock_nested_bh(&gcells->cells->bh_lock);
 	rcu_read_unlock();
 	return res;
 }
