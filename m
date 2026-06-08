Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB63E120D
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943639; cv=none; b=oiB11GhUbXt9dQkU4ddoFRieJIaKQ/zR/7Cja+omo1zqx+tEjP3q76lE7qsecankXjwh9PVTI/0QhbNxi515YMPohky/rdw9MASV+qpp7bDKeMdetpieAPlhD0Qw/BUggJlofj1+b5bpvlSe8rfJ2prmphHxGARN4bTdy7IoFCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943639; c=relaxed/simple;
	bh=WGOev7ZI8WNZEhymaVSVw5Z9SCEEQCHHGCoPCSw1YeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0yz4tZ6IlQtmdUKg0/Wah2FYuvyoviOveeu7demBD7ZXh4RU5l2ja0GSB5tvCZjlzcX8vZ9IlB2eW5f4FW/eD3vd6j7+HSrxVfgGuvt5HwajBdUDEJ4YdjJkdWU04gQHgwI0+l2Wut/HqrUv1JLH+VbcBfrkE529Cu5YvSk9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYfd9rTz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYfd9rTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCobhDDwiF+oGZC7fH93esERuJcwSNbJp32xXAqy0I0=;
	b=VYfd9rTzyUI7A3NVWxJGM4IjvEddnr0DfZU0Ed/3XmJ0PDkjsLg87AAJRLxQNQ37evUoJc
	JuCA8rtcd2yqLNA+74JT070q9FfhdpwoRaHmo/jDxHP32OkieENZqw2dwIJ378VbG4Pgvi
	//Dxz4V4chpLYEbEa6WTByBhHHb8vQs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-DHOnEb2lNUCdllmOiHRzNg-1; Mon,
 08 Jun 2026 14:33:54 -0400
X-MC-Unique: DHOnEb2lNUCdllmOiHRzNg-1
X-Mimecast-MFC-AGG-ID: DHOnEb2lNUCdllmOiHRzNg_1780943633
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E076187B984;
	Mon,  8 Jun 2026 18:33:53 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35E8F36928;
	Mon,  8 Jun 2026 18:33:50 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 36/52] stalld: fix uninitialized buffer use in find_debugfs_mount_point
Date: Mon,  8 Jun 2026 15:31:46 -0300
Message-ID: <20260608183206.140526-37-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The return variable ret is initialized to zero, which signals success.
If /proc/mounts contains no debugfs entry the loop exits without
writing to mount_path_buf and the function returns zero. Callers then
pass the uninitialized buffer to strlen() and snprintf(), resulting in
undefined behavior.

Initialize ret to -1 and set it to zero only after the mount path has
been successfully copied into the output buffer.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/utils.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/utils.c b/src/utils.c
index 3dddb0f..90a0024 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -1226,10 +1226,11 @@ int parse_args(int argc, char **argv)
  * @param buf_size The size of the mount_path_buf.
  * @return 0 on success (debugfs mount point found), -1 if not found or on error.
  */
-static int find_debugfs_mount_point(char *mount_path_buf, size_t buf_size) {
+static int find_debugfs_mount_point(char *mount_path_buf, size_t buf_size)
+{
 	FILE *fp;
 	struct mntent *mnt;
-	int ret = 0;
+	int ret = -1;
 
 	fp = setmntent("/proc/mounts", "r");
 	if (!fp) {
@@ -1244,9 +1245,9 @@ static int find_debugfs_mount_point(char *mount_path_buf, size_t buf_size) {
 		if (strlen(mnt->mnt_dir) < buf_size) {
 			strncpy(mount_path_buf, mnt->mnt_dir, buf_size - 1);
 			mount_path_buf[buf_size - 1] = '\0';
+			ret = 0;
 		} else {
 			warn("Buffer too small for debugfs mount path: %s\n", mnt->mnt_dir);
-			ret = -1;
 		}
 
 		break;
-- 
2.54.0

