Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C81C433DB
	for <linux-rt-users@archiver.kernel.org>; Sun, 21 Mar 2021 08:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7A461930
	for <linux-rt-users@archiver.kernel.org>; Sun, 21 Mar 2021 08:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCUHra (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 21 Mar 2021 03:47:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:35115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhCUHr2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 21 Mar 2021 03:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616312818;
        bh=SuG/TA7sCK4l9pQ8LvndcMV7fjeqGSpXtyAJ9CMDF7c=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ijIdDW684lpym5a2OHjhc3OlaF78IlxT20Ix+Wk74scJM8Xl2A76bH8lW8cd3uDz5
         E9ndUmNjLGGAhtMO8IjP0ntWPEySeAmXueNvVPUCqg1tCceSHMRYrnjzqNzXXdktRW
         BCbF2ydeluR3X2WomTHLByNpmGCavYjn3vc9m5co=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.199]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt757-1lhjw3076v-00tVKq; Sun, 21
 Mar 2021 08:46:58 +0100
Message-ID: <e2e51e78094d14f6795221734c2fc8d66d6455a7.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.12-rc3-rt3
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sun, 21 Mar 2021 08:46:56 +0100
In-Reply-To: <1f63f1fcea10fc179881384cd838b1c9e5207b82.camel@gmx.de>
References: <20210319223357.uknv2t5uvxvzb46x@linutronix.de>
         <1f63f1fcea10fc179881384cd838b1c9e5207b82.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5WpsyfvFngwZ4W11hzRr4dl+GGSxMLC9KVKOmzLjq9jB68TrDDg
 TwRzucfzOCRwjb3DCDU7XL0Xkz6HBesfz4VKu7l3wjotqKkYH4E/TNPmwUv5GJT7K+iZ5G/
 tD9G02hMQuwuoDl3fxtNVYrLVl3yasDWVDSzM/lDFnxsrkfcydkOMlWuLbLWRTt4H7yV70T
 2su/poxBiQ1MS15Nd/GrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j2ayHTvOodI=:wxmEyrNzqEay9q3FQO+xxX
 NVefhFnx0ZwUNix1MIFxtEt4TRSbhkmqeFnSvH4GXtBjfG0zK+sWJJz6ozvk0lwoS6CvCQYE3
 jN7Qrzt9fct1Ao0Ehi/gC9m382Al90I4Jqafx1lOLZX98OPGO2CdWCean5uoZhTFDMyg6oKi7
 MtByerOg1lKa1WVeW9Cua1UWAht+pUc+EhM8jj84yKSWVIkKsTlU80qNUdHiXtti3QBGgoVbN
 zT+krvnU4e2Jzeu19sf8LHVpO21LZDkwKfRmPjX81I3fH3YkNA8kqhDV9Cu2VKRtB8AaxVs+X
 NPE19jXPCgoAtPfr4KFZ7z0cYKGCkBJSZIDIdW1OpaWzS07IQHSR4Yfz6bcDtvwrTHXAE+DIs
 rlNBk4IGaSkZzv36VdkhljCTHZoQTdTktl2pzIKqD3Oxl3hJVU6BpKuvNSOR5udo9kMDBhyXL
 5N1AoEcWTaFh+5aziAAmFbFpILYVJc7ZvOJlp2+SWjqawL5LsgrlO7R4IsI7w+PWkG9DoOsgw
 +eI/xWs/268ytlLIKh3DLPuRTrRRpyNhC7OiGzYgiKV0g6Gyx7KIIoy2ikHP/ENGJM0/N5kEZ
 G/CN0URHzuaFlSp1Nhec2rMjgVXLBuhDQtDpL8V428byY/HnjqqNHCoURMv1ZEtJCRjNUEume
 U1C7zin1b/bLsmjM3DM82jsWFr64D8MeC+nyNXUImYmnQZ9XHa/3CrW+dOrx7wnGta+JEcUtA
 Sz8Bu/J5myXI83iulMgrLFt3uP6ZnlwfE2nABVTMV7FbPukTJofocvcOCeIP2kOF+bf/l+E1E
 gxCp6byEr8PHb8Zu0G3lyBfvQ2qdEdxhzhb2eOIyfxtwyyRfEZJbC39Zyj88rSr7vugJYKnb6
 V7rvGpZ8JbUBL/YkU4EA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 2021-03-20 at 09:18 +0100, Mike Galbraith wrote:
> On Fri, 2021-03-19 at 23:33 +0100, Sebastian Andrzej Siewior wrote:
> > Dear RT folks!
> >
> > I'm pleased to announce the v5.12-rc3-rt3 patch set.
>
> My little rpi4b is fairly unhappy with 5.12-rt, whereas 5.11-rt works
> fine on it.  The below spew is endless, making boot endless.  I turned
> it into a WARN_ON_ONCE to see if the thing would finish boot, and
> surprisingly, it seems perfectly fine with that bad idea. Having not
> the foggiest clue what I'm doing down in arm arch-land, bug is in no
> immediate danger :)

Actually, it looks like a defenseless little buglet, and this gripe
simply wants to be disabled for RT.

arm64: disable arch_faults_on_old_pte() preemptible() warning for RT

arch_faults_on_old_pte() was never called in < 5.12-rt, but 5.12 added
arch_wants_old_prefaulted_pte(), which is a wrapper thereof, and thus
finish_fault() -> do_set_pte() -> arch_wants_old_prefaulted_pte() now
calls it, in preemptible context, and a flood of complaints ensues.

Kill it for RT.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 arch/arm64/include/asm/pgtable.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

=2D-- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -979,7 +979,7 @@ static inline void update_mmu_cache(stru
  */
 static inline bool arch_faults_on_old_pte(void)
 {
-	WARN_ON(preemptible());
+	WARN_ON(!IS_ENABLED(CONFIG_PREEMPT_RT) && preemptible());

 	return !cpu_has_hw_af();
 }

>
> [    2.216913] WARNING: CPU: 0 PID: 1 at arch/arm64/include/asm/pgtable.=
h:982 do_set_pte+0x1cc/0x1d4
> [    2.216949] Modules linked in:
> [    2.216961] CPU: 0 PID: 1 Comm: init Not tainted 5.12.0.g425ed5a-v8-r=
t #33
> [    2.216973] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
> [    2.216979] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=3D--)
> [    2.216990] pc : do_set_pte+0x1cc/0x1d4
> [    2.217004] lr : filemap_map_pages+0x178/0x380
> [    2.217016] sp : ffffffc01153bbb0
> [    2.217020] x29: ffffffc01153bbb0 x28: fffffffe07d93080
> [    2.217033] x27: 0000000000000000 x26: ffffff8101c9e000
> [    2.217044] x25: ffffff8101b40fd8 x24: 0000000000000000
> [    2.217054] x23: ffffff8101674170 x22: 0000007fb1b4b000
> [    2.217064] x21: fffffffe07d93080 x20: ffffffc01153bcf0
> [    2.217073] x19: 00200001f64c2fc3 x18: 0000000000000000
> [    2.217082] x17: 0000000000000000 x16: 0000000000000000
> [    2.217091] x15: 0000000000000000 x14: 0000000000000000
> [    2.217100] x13: 0000000000000000 x12: 0000000000000000
> [    2.217108] x11: 0000000000000000 x10: 0000000000000000
> [    2.217117] x9 : ffffffc010209068 x8 : 000000000000000f
> [    2.217126] x7 : ffffff8101e87c68 x6 : fffffffe00000000
> [    2.217135] x5 : 0000000000101e8b x4 : ffffff8101e880a8
> [    2.217144] x3 : 0020000000000fc3 x2 : 0000000000000000
> [    2.217153] x1 : 0000000000000000 x0 : 0000000000000000
> [    2.217162] Call trace:
> [    2.217166]  do_set_pte+0x1cc/0x1d4
> [    2.217181]  filemap_map_pages+0x178/0x380
> [    2.217189]  __handle_mm_fault+0x75c/0x930
> [    2.217202]  handle_mm_fault+0x178/0x25c
> [    2.217214]  do_page_fault+0x16c/0x470
> [    2.217233]  do_translation_fault+0xbc/0xd8
> [    2.217244]  do_mem_abort+0x4c/0xbc
> [    2.217259]  el0_ia+0x68/0xcc
> [    2.217272]  el0_sync_handler+0x180/0x1b0
> [    2.217284]  el0_sync+0x170/0x180

