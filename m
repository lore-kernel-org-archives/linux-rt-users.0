Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4198D28374
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380463; cv=none; b=X0KMuLYCimWZEH2gZ0jXMiqn1qJFJAwEAdad6HjtIMfR/lEibko5g/vMd+7pblfQnPxjk3HeKjbiLNd0AuGYorKrgvJL53fsAktTE2Bca4OyiROgv9mBfi+nhVp3ylEztSP2MFavCP/w+KHa5OxkfoQi+uS7akMEKx4niS1iadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380463; c=relaxed/simple;
	bh=rjCuJ0XV/otE6anrp39SvtUVN4yvBx5R3opBNGPh1PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXVMnQBCbISGYComQn4wMPEEofoNufBQSggekVsgbkcftFUfVtoml4swz9CoCXoC9eM90QFiY3QBCOfhfhgiRREL8rUPvFhzGfYog/Mg2GV6bIRo2moz01LlTKvhj1+BScsE5FiJsFC4ZCkNi5lTuabvQeGO7mwpJBl45xUHB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nbkg51Yw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nbkg51Yw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714380461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xKo6bQR3fq6POX1YbKZ5iCWNelODGbd1b9age1v0Lfc=;
	b=Nbkg51Yw/CBJsuOpn7jtIAd7jtimTwLygmh3Kg5rOi9O4K8h0TK1ZtJGjtFB9edavV2Udr
	vGIjxNsxHfhTAAO85lh3okihWOIWsxbHJIItVvOszYgeKuW1hFmtnE9VE5fvdZxY6976pf
	+dgwv/OL6sY6cMpGk35VrPgTlrUqsKM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-WYTOFQqLMMupRgGZ62Ic5A-1; Mon, 29 Apr 2024 04:47:39 -0400
X-MC-Unique: WYTOFQqLMMupRgGZ62Ic5A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CC3318065B1
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 08:47:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.219])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3679740BB4E;
	Mon, 29 Apr 2024 08:47:38 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rteval: Make output work with new dmiinfo format
Date: Mon, 29 Apr 2024 10:47:20 +0200
Message-ID: <20240429084720.126511-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

From: Tomas Glozar <tglozar@redhat.com>

Commit 43c45ba7 ("rteval: Implement initial dmidecode support")
re-introduced DMI information into rteval XML summary, but in a
different format, which is not correctly picked up in rteval_text.xsl
for formatting BIOS and vendor information into rteval text output.

This lead to the information not being displayed correctly:
   Model:         -
   BIOS version:  (ver: , rev :, release date: )

Modify the relevant section of rteval_text.xsl to make it understand the
new format. Also, adjust the incorrect spacing around "rev".

New output (in QEMU VM):
   Model:        QEMU - Standard PC (Q35 + ICH9, 2009)
   BIOS version: SeaBIOS (ver: 1.16.3-1.fc39, rev: 0.0, release date: 04/01/2014)

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/rteval_text.xsl | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
index 1e9c0f0..2f03bda 100644
--- a/rteval/rteval_text.xsl
+++ b/rteval/rteval_text.xsl
@@ -39,18 +39,18 @@
     <xsl:text>&#10;</xsl:text>
 
     <xsl:text>   Model:        </xsl:text>
-    <xsl:value-of select="SystemInfo/DMIinfo/HardwareInfo/GeneralInfo/Manufacturer|HardwareInfo/GeneralInfo/ProductName"/>
-    <xsl:text> - </xsl:text><xsl:value-of select="SystemInfo/DMIinfo/HardwareInfo/GeneralInfo/ProductName|HardwareInfo/GeneralInfo/ProductName"/>
+    <xsl:value-of select="SystemInfo/DMIinfo/Handle[@name='System Information']/Field[@Name='Manufacturer']"/>
+    <xsl:text> - </xsl:text><xsl:value-of select="SystemInfo/DMIinfo/Handle[@name='System Information']/Field[@Name='Product Name']"/>
     <xsl:text>&#10;</xsl:text>
 
     <xsl:text>   BIOS version: </xsl:text>
-    <xsl:value-of select="SystemInfo/DMIinfo/HardwareInfo/BIOS|HardwareInfo/BIOS"/>
+    <xsl:value-of select="SystemInfo/DMIinfo/Handle[@name='BIOS Information']/Field[@Name='Vendor']"/>
     <xsl:text> (ver: </xsl:text>
-    <xsl:value-of select="SystemInfo/DMIinfo/HardwareInfo/BIOS/@Version|HardwareInfo/BIOS/@Version"/>
-    <xsl:text>, rev :</xsl:text>
-    <xsl:value-of select="SystemInfo/DMIinfo/HardwareInfo/BIOS/@BIOSrevision|HardwareInfo/BIOS/@BIOSrevision"/>
+    <xsl:value-of select="SystemInfo/DMIinfo/Handle[@name='BIOS Information']/Field[@Name='Version']"/>
+    <xsl:text>, rev: </xsl:text>
+    <xsl:value-of select="SystemInfo/DMIinfo/Handle[@name='BIOS Information']/Field[@Name='BIOS Revision']"/>
     <xsl:text>, release date: </xsl:text>
-    <xsl:value-of select="SystemInfo/DMIinfo/HardwareInfo/BIOS/@ReleaseDate|HardwareInfo/BIOS/@ReleaseDate"/>
+    <xsl:value-of select="SystemInfo/DMIinfo/Handle[@name='BIOS Information']/Field[@Name='Release Date']"/>
     <xsl:text>)</xsl:text>
     <xsl:text>&#10;&#10;</xsl:text>
 
-- 
2.44.0

