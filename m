Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA61079C
	for <linux-rt-users@vger.kernel.org>; Mon, 25 Sep 2023 07:09:16 +0000 (UTC)
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB636B8;
	Mon, 25 Sep 2023 00:09:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF55CE1A55;
	Mon, 25 Sep 2023 09:09:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1695625752; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=on6U5DvhGM7n2MBzI3nJQOCerkRFHOB9ieGT0tTQoB4=;
	b=NBiF6DFUX1noQ8RBmDcSS95451DeNYlDSETXDmIFeIUh3mSxWkpA9jf3UGeT1kwITGEb23
	rpG2p7fHuC2/RwhDlJR6WW0AThVWVG6bgJ+8j/v+5ErltNwM/+Gu5pwyd7dyFHfnYJTes4
	vSqgiXv5ugaepd8fYlbvx+7Bs6KUdUcps/vavDZ0BikMGvzwpt2cnwNHzZjhW4ZoKYnxUg
	pdgkX4zogmnVu8OywqSrGoOHIeA5cidBEo9Yrm2iRM5cZX7Huce+Bu3L7zGzThSYBWFnqr
	bhlPTajhZ3Nzy+N3EK0WrPanou174m5JqwNyiIHWV9QEW6dG9yNAG6NDebKrQA==
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>,
	 <linux-rt-users@vger.kernel.org>,
	 <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/1] Linux v4.19.295-rt129-rc1
Date: Mon, 25 Sep 2023 09:09:05 +0200
Message-ID: <20230925070906.20584-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.295-rt129-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2023-10-02.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.292-rt128:


Daniel Wagner (1):
  Linux 4.19.295-rt129

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.41.0

