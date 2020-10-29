Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3362C4363A
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 07:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C8E214DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 07:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hWheqr94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgJ2HXC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 03:23:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:48689 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgJ2HWW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 03:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603956140;
        bh=vzsyNj3lJxWCc3usu0lnsRZ5XQk7Q5W9sm/AlnXgojE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=hWheqr94+5FJoUEdjmtcAIhVb5TPsFBO8R9w5HMYsYKRkejVkkMmvRJJW6NaPJQ63
         cd4Zxk7sA2dBUX2+c3lwCFzIaJRTfVOExdL508c53kIWByI/QjHBSab+w7RujhhBY/
         s/cO1pBhhL7EnqE1qgWRss8hJ/KxlXXOLIacxf20=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.146.51.69]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf0BM-1jroB82nSU-00gcRa; Thu, 29
 Oct 2020 05:37:44 +0100
Message-ID: <0945ac2959a7ef04f5b3eeaa28b71261c7ccfeb2.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.10-rc1-rt1
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Thu, 29 Oct 2020 05:37:44 +0100
In-Reply-To: <20201028205853.rw2j3dtuyvup6lai@linutronix.de>
References: <20201028205853.rw2j3dtuyvup6lai@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9WtvzFrYAZAcIiBiWx6anW4PHPYyWJCvF4UDeOSetkraddlJ+Sl
 dDDxonXuLbcTjtc3lADoTms3zczL9aXq7lDW4Sw5Rvm4/txOM0f+HmUGiPI/1CEqT/kopmx
 mzrniKE0rIP8VBPxW+Eox1mi123uTornlnY4vhrSc+oaeo8sjrcnrJ/Eh6MEYLFWPIDqUoY
 GA9VfUuuxCWgTdP2rRcMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iHAr6Iz8uyc=:H015NJ7E8ZVckcvWeXFSj+
 cZGjGY/M/SM5CSgIxqHAVDCun2/IzbOU/IWq0JovEi4UDKroYYHXhBHlzP5MTjyEdjGZQIWj6
 QZCOdf1IPWJKrgORNIdfZ9XeUdWvEKzOT8c5JAg1+g5WjygJgWZWLcie9ln3Bump2hcNWhcO8
 LsMq7eu1KI5pm53qWSNMCCZUZW+h01biX12VXKdbW+c4lywslbRGLVZb0StX0NuOC6Z4JsnA3
 p1+/4l5fFElMGg+mpooNH0ScxD7tfuvp/0Gzyi2ClPA4ken8CPGba+fxhy3zsAEKpzAL0J8TJ
 JfJLIuK37J473++xPTlJpc0X4Pfaa9Z+1iZzVCSVuRXLnLtoJFz6Jk5Py60SwrSyFPq8SY2NL
 CYB009EmHLUmgB9S8FoajxCpf6mNCPKt8o7PP6yRgAkuArNppZLGeCzeDhSxrxP9T8wB/ohla
 X2DRawLSRNzTOUE5xKkYXUL3TsXlC3+fPWGr53vq95QpfpeabY3liEMoxVJFozmwK7QLd4veK
 on/PwbS5SPF9xgonicJ/nNK/rkQoCy8b62J6aHcpLQOkN0rGIlySzjScYSpLh4KB89BBJIUmr
 huDgtQ7JZMTqVmLUWOrFWB8Ab4QnAYe0/HpDnkfzgwrvoHbu3x3FrjW+lKz3OL+eiXVCkfCPL
 1chgkkWkI04LtRDOQ5QTh5SmjbyMHosWa1DQ37TCampLdWxGgVlExl9TiEozL7eIISoQDn4rK
 B4vRxr7ydmCEzAFZXbrfIfV6SksVnzqnsKjdlLN5LSw47uQ//qW5ydwgdTpcVvUkthnPc976N
 goow6wyw4CsatLoy4Lt8nPZ2uPzdTefFfVsvEwZDCzsiJJ0ZyAGekf/atEbHvYWSJ6bnc8umi
 E4u1R1FRFie9n28L5HPQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

"blk-mq: Use llist_head for blk_cpu_done" needs a minor adjustment, as
is it induces much grumbling...

BUG: using smp_processor_id() in preemptible [00000000] code: usb-storage/=
479

@@ -657,6 +621,7 @@ static inline bool blk_mq_complete_need_

 bool blk_mq_complete_request_remote(struct request *rq)
 {
+	struct llist_head *cpu_list;
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);

 	/*
@@ -667,14 +632,21 @@ bool blk_mq_complete_request_remote(stru
 		return false;

 	if (blk_mq_complete_need_ipi(rq)) {
-		rq->csd.func =3D __blk_mq_complete_request_remote;
-		rq->csd.info =3D rq;
-		rq->csd.flags =3D 0;
-		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
+		unsigned int cpu;
+
+		cpu =3D rq->mq_ctx->cpu;
+		cpu_list =3D &per_cpu(blk_cpu_done, cpu);
+		if (llist_add(&rq->ipi_list, cpu_list)) {
+			rq->csd.func =3D __blk_mq_complete_request_remote;
+			rq->csd.flags =3D 0;
+			smp_call_function_single_async(cpu, &rq->csd);
+		}
 	} else {
 		if (rq->q->nr_hw_queues > 1)
 			return false;
-		blk_mq_trigger_softirq(rq);
+		cpu_list =3D this_cpu_ptr(&blk_cpu_done);  <=3D=3D there
+		if (llist_add(&rq->ipi_list, cpu_list))
+			raise_softirq(BLOCK_SOFTIRQ);
 	}

 	return true;



