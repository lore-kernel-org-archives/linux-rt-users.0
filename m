Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747243E08F
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223977; cv=none; b=BemiLhT4YlF+waa46k5DM+JFhBBUaCnkRLnYkU5m79A5FMQigBgwWn1+MS6DzwuidNq1KCrF1nf0CNQxk+UJF+zpmCre5dQ3pWMUkpIQUnEzVmVqPwdvoGY9+TyyWaLz12YoGC0iaLUZKBQd429Qbi42wOqNbJ2QPXHBKjcx9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223977; c=relaxed/simple;
	bh=+8tpPmPZ3HFtnp3U2IE8tlCAoy0/TDnEv4ynTTXMvnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im37mP8aENQzpJ+MGtybOR1qPlreK6WtS4GUNdjw5RevpsKaSwdhmMIcGBBrH1hL84c+cnknxAqEBx5eJHDgKxd/ALBuHSKpqtSjs0q7neznBoWLni/1Yu9NTLz9o2tRaI8Vo+yEghmO0gDixFIQHGkSBWXITRJgyshDhIyHxSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zl2+mVQq; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl2+mVQq"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-902f92b8504so61693856d6.2
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223975; x=1784828775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Avhs3r/v7m8Q0K9C3DfZcC9wjapFzH0KYGP44646j7M=;
        b=Zl2+mVQqHThxpB3GKv2caup+uKvOOC8enTJo4xt6f7AowGBkWAqUFw2rfk/zERjgt/
         pwGtmGlkCpwJxbwFhk+IvlNrt7GyelXPDyt0/gpQ63ocJc/3PMJnLwfAWI23TaDfSxUU
         WtrCgK3ZvJ/Unz02GE65qcwmZXp4+7+Sg02dy645YiEP8CAWVAS3qzELZ734i3imbaeH
         MazvMQ0dxybi6zyywe7aLb+oglRA+EqFhg844abOlwNyN0Xy59JhAg3bV9htdU8sN+MV
         pao/QlidRsiBwSfykzWgtFMeWIsom5Ohxg7qS7GEAu26fn6KhsUqKbM2CQKHIPedCqdK
         ykbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223975; x=1784828775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Avhs3r/v7m8Q0K9C3DfZcC9wjapFzH0KYGP44646j7M=;
        b=RaLwCDGd5t5ZOkkV/EapwMU1uHFxH7N2Q8OU/VQh+T5r482IIbZx7zmAvYJhLOyQ2I
         YlQhzDQA/meUEFEV+Xp9Kg4v9Kp6k4tp7MHgZOC5PaZTfiJvIJhJdVZ89pvoeh9VmBDe
         4eIfo3FmUgJ4kfGR9NnNzURbyGMzexdXTWyxF052F1zJQnWo25tVljeduv30+6yfR2FU
         TTR0yj3P46Fp//wiJxe21EKDUPJUifKGAB/zfFMSe/VgI1duj5eUg3UWxdtX6WFdBO0e
         mNtEafgZGzGXuA1WOXrqy4nIsAoTduLaO+gaOIQTHQM79GSgyF/28xUsmzBwl8bXaIJT
         0Lyw==
X-Gm-Message-State: AOJu0YzZXXpplucecei1VjHpvSk+2n2QLXVdSTb5N7VKSlYmrk3iSewR
	cxqURh1fV0H5/c+FV990NkYRkA/Iiz4GXztg3nHsm10L1JfsMx4+G0fBpy2Emg==
X-Gm-Gg: AfdE7cmoDFRYrwxx532fs3JMhkoan1C/AkNfFxaV7yI4mkyZR9h7y0Ypv4yjtDPU9KJ
	PgEv8D3KRXlUbNNc+7ceDLxqbejKQPSZ8vOva2XmJjHPg8OPd6yP7TkNfr41EBUXnElWO5x3GXH
	JqOks0zglPJAZiUCvD4YqUqZ7sAo5SkZQUZbuHk/ux0vEH3fFORAqGY1pg7dOQGj8cFQaKVszFr
	/vqLiSrNL+wSEKAl1CbW3LAfhJrlDs/fj2QVqiHZAIEXr5//Lt1adJy1PgeRz5Zi4yK+B+Vw1mO
	eYwREDskww+U8be2bd1Rfa8HsrT0GM6T3JImsRf1mSo1ZqOMc283r5KMYQ/N8vBZH2I+FV/MDaT
	KyVS9o5Cdul7F2j3+k2Bxk1REvVu5/e4aBpgybfciVwAql1hC7p4VN0q0q0CEHdrrK/fpYhpLUF
	IiRvB0IWO/o355GgLVHANvDBlcSOMLpoHwbrdun8TMl452prGPEvhIj6rk4XFAGHoRavJw
X-Received: by 2002:a05:6214:2465:b0:8f0:afa3:594e with SMTP id 6a1803df08f44-90758cbff9fmr97612496d6.8.1784223974532;
        Thu, 16 Jul 2026 10:46:14 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e0347sm224952276d6.2.2026.07.16.10.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:46:14 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 4/7] tuna: Remove obsolete apply command functionality
Date: Thu, 16 Jul 2026 13:45:47 -0400
Message-ID: <20260716174554.126145-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716174554.126145-1-jkacur@redhat.com>
References: <20260716174554.126145-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the broken apply command infrastructure that was disabled in
commit 959a16ce. The apply functionality conflicts with the recommended
tuned-based workflow for sysctl profile management.

Removed:
- apply_config() function (only called from commented-out code)
- Commented-out apply command handler
- Unused "profilename" argument definition
- Debug print statement in config.py
- Unreachable comment after raise statement

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py    | 28 ----------------------------
 tuna/config.py |  2 --
 2 files changed, 30 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 4eba82aac412..b78837c614e5 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -111,7 +111,6 @@ def gen_parser():
             "cpu_list": dict(metavar='CPU-LIST', type=tuna.cpustring_to_list, help="CPU-LIST affected by commands"),
             "thread_list": dict(metavar='THREAD-LIST', nargs='+', help="THREAD-LIST affected by commands"),
             "filename": dict(metavar='FILENAME', type=str, help="Save kthreads sched tunables to this file"),
-            "profilename": dict(type=str, help="Apply changes described in this file"),
             "run_command": dict(metavar='COMMAND', type=str, help="fork a new process and run the \"COMMAND\""),
             "priority": dict(type=tuna.get_policy_and_rtprio, metavar="POLICY:RTPRIO", help="Set thread scheduler tunables: POLICY and RTPRIO"),
           }
@@ -887,30 +886,6 @@ def i18n_init():
     gettext.install(app, localedir)
 
 
-def apply_config(filename):
-    from tuna.config import Config
-    config = Config()
-    if os.path.exists(filename):
-        config.config['root'] = os.getcwd() + "/"
-        filename = os.path.basename(filename)
-    else:
-        if not os.path.exists(config.config['root']+filename):
-            print(filename + _(" not found!"))
-            sys.exit(1)
-    if config.loadTuna(filename):
-        sys.exit(1)
-    ctrl = 0
-    values = {}
-    values['toapply'] = {}
-    for index in range(len(config.ctlParams)):
-        for opt in config.ctlParams[index]:
-            values['toapply'][ctrl] = {}
-            values['toapply'][ctrl]['label'] = opt
-            values['toapply'][ctrl]['value'] = config.ctlParams[index][opt]
-            ctrl = ctrl + 1
-    config.applyChanges(values)
-
-
 def list_config():
     from tuna.config import Config
     config = Config()
@@ -1661,9 +1636,6 @@ def main():
                         print(f"[ERROR] Invalid RT priority: {rtprio}. RT priorities must be 1-99", file=sys.stderr)
                         sys.exit(2)
 
-    # if args.command in ['apply', 'a']:
-    #     apply_config(args.profilename)
-
     if args.command in ['include', 'I']:
         tuna.include_cpus(args.cpu_list, utils.get_nr_cpus())
 
diff --git a/tuna/config.py b/tuna/config.py
index 63c9f23bb09b..7f0df96fa655 100644
--- a/tuna/config.py
+++ b/tuna/config.py
@@ -112,7 +112,6 @@ class Config:
         if profile[1]:
             raise RuntimeError(
                 _("Can't activate tuna profile in tuned daemon\n%s" % profile[1]))
-            # return False - unreachable code here!
         if not os.path.exists(ldir):
             try:
                 os.stat(ldir)
@@ -150,7 +149,6 @@ class Config:
         return True
 
     def loadTuna(self, profileName):
-        print(f'profileName = {profileName}')   # REMOVE
         err = self.checkConfigFile(self.config['root'] + profileName)
         if err != '':
             raise RuntimeError(_("Config file contain errors: ") + _(err))
-- 
2.55.0

