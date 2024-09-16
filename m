Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAD25FB9C;
	Mon, 16 Sep 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481942; cv=none; b=uCSDPR5daueRbb3WiGYKWm2nlSRZzvZjMGjwhahGxEHPzYou/6GvzilFJNBeloyqFUSPJBkeK9psJQPRxxEHHT4YkbVpCIio69vvQW1LIJJ4hSbHA6TnJ+E/Zg/divlBPq6d+3hp2CH9n3pulRAEUEwIhCZDSR+tajNekbXcn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481942; c=relaxed/simple;
	bh=YONs79CHg94BdTBFdnTQkbFOUhcf3vOSybL4fqimPK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QwzFk6FEo92pND2vdI8irsuhE7YjL1WXo7j1cRErFIcUD9KahRE/Ip0kfsc0dnLlXMhrehcA4g+iwXXEJtnYitXuzDEy9KOjVorUhybJlFSeGsKhkHeYCqRimHvmz7nfKr2rzYah01q7SAepValrt+UaL+sCFofw+nyGawG3dIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=zExUP4SA; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="zExUP4SA"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2678FDB259;
	Mon, 16 Sep 2024 12:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1726481932; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=vEZF0nMlD2VC8XTumwqyx5LzxAmk5mEEC58K81DC2fM=;
	b=zExUP4SAl2XSNW4EIAdEDg0t21+SmRLn3YlmzwoIN8pmOqgH0mfkZo+nZ/fjc06PmlUOAI
	hvXR1vmhC2ln8XuIayfj4VeT+gOd3KO0AFTNHoSnkyoChv58tJrlVUav1k23vge3TiCg+/
	mc4h/5DeAzFndlSUC9M7ZFkWDxIFzwNhVTVQdnId9zGy9Dx/Bydo8qOI6YYwsM8hGaxdVZ
	oiro5peJeR0nwZp85WEh11fVklb0ToNen6OUYplI8prhwJO1HJfeZpizu20rLxvA0COSsa
	szpjPUKLDtvBR+5K/prfTDzlr2VVp5JVvvHd5NlikdcC58oUkAGXHH93fXS0qQ==
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
Subject: [PATCH RT 0/1] Linux v4.19.322-rt138-rc1
Date: Mon, 16 Sep 2024 12:18:43 +0200
Message-ID: <20240916101844.280673-1-wagi@monom.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.322-rt138-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2024-09-23.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel


Changes from v4.19.317-rt137:

There was a merge conflict due to the backport of d33d26036a02 ("rtmutex:
Drop rt_mutex::wait_lock before scheduling"). This commit added the lock
argument to rt_mutex_handle_deadlock function.


diff --cc kernel/locking/rtmutex.c
index fe5153fc7665,c552fb0b54bc..d012e35708c6
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@@ -1753,12 -1270,8 +1755,12 @@@ int __sched rt_mutex_slowlock_locked(st

        if (unlikely(ret)) {
                __set_current_state(TASK_RUNNING);
 -              remove_waiter(lock, &waiter);
 -              rt_mutex_handle_deadlock(ret, chwalk, lock, &waiter);
 +              remove_waiter(lock, waiter);
 +              /* ww_mutex wants to report EDEADLK/EALREADY, let it */
 +              if (!ww_ctx)
-                       rt_mutex_handle_deadlock(ret, chwalk, waiter);
++                      rt_mutex_handle_deadlock(ret, chwalk, lock, waiter);
 +      } else if (ww_ctx) {
 +              ww_mutex_account_lock(lock, ww_ctx);
        }

        /*

Daniel Wagner (1):
  Linux 4.19.322-rt138

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.46.0

