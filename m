Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB082C6B6
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Feb 2024 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342585; cv=none; b=hHJ8QveTwAoPPfM/C4v5aa+uIlcXjKM0SznmpSxApylJnWKUNyzVLwIWbunWCUGiuRcEZmfpbzNMK84IAG+L3rvMd5A/gyABT8hcpwP4d01RZv5C3H6ygWQor7iLpdTbYMshSWv9tnOuW4RmbJjGHU9fFiawv+VOC8Fk/0DlScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342585; c=relaxed/simple;
	bh=jtSW/8yrLNaZf+TBhVG4Zn3bTjJbKYPm+Btll2JMFIE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EAUzeKqceVhxmxdeWNHcYLWFJeGFxz2ze2kNcpdgHz6mmKzt2u+XbJ7OEdqDDRr5ZKNymibyRlz++Skw4Ymc+lJl8Iyo3tUW6GE0XfuI735CzAbg+7xZkVOQ1909mC6kD8IZ1tjLCUhM4B6vuUwqtaxB1557OeHbyBqUNSFkHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NZbT2Y44; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NZbT2Y44"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dbcf58b05cso149415ad.0
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Feb 2024 03:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708342583; x=1708947383; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jtSW/8yrLNaZf+TBhVG4Zn3bTjJbKYPm+Btll2JMFIE=;
        b=NZbT2Y440qUesHnPbbxHpejBTDQfbaK2uW/BGUYHwHYodYkta27BG4ThvvOiGY0BUo
         No+U6PXQsIcYUwldzmdHVJCWgJzsCKS26D4VwITrcOgx4+y1hCO4PSlNsrLHJhzl2zzd
         LvlzNqhjvPln1cTr+cFPNilGyAP56vmQqsyTnpp5iAwd6BYSxhkB+QDPiOdJaOE01HsW
         o/3I4GHgPQqDvlZAu173hEN7EYwCUaDq+L+f+GFoV379houLb8Y0ejv14bqbYubnAa6K
         OYrdpnls93lADD4SmdrGMjwtVZ4WJfVu/0UnqJv5UY+qkeAePt822sE8dq6R8Vn5HAd4
         W8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342583; x=1708947383;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtSW/8yrLNaZf+TBhVG4Zn3bTjJbKYPm+Btll2JMFIE=;
        b=bUsAvAoyTMWvHBOyvznriCuKwCiuqwmbl53c9lvlU+9h17mgDrip/R/+C/cmiFKBSW
         umNS0DYfOm1dIoZp4wxhJfPW87ikZq8hvxhkB3ndvc/pyqHIMQTCUDkJSdEfVYwnNLFq
         r8m+cL3Fyj3rsfOZrC5oAktEmdl/sDXwiBGqoufXdG0fc2nM7O+2h6WD27ivk82jcUhq
         MnM6v/5tHxhDsFxH3fDDlmbhZMunRBj93opW0PRIEBLQ417M9HhCXjsW7QkljALrtcNz
         oaO6qvaWH3eWyr0mBWGEOrfr2k/MyXNupQZW4rpCP5FoK3CS+cs63Kg8xx4U9becFL98
         Sr+A==
X-Gm-Message-State: AOJu0YxGx58bp8ZQTiAhqfE4TtRhwUxYzDddhKenBeVtyAbDEjiDz0Ii
	Q4nSSSUvGIBwWT/XsPkSi0t55tCpREdOXCH+QIbFTr9mNM2DBpn4SFBxCa3QnmPVu2V24RD/Gqs
	6ypD3b0YpEJabadijmwEIblubet54mFh2ELdpWltIcNNG4Bt6W2Is
X-Google-Smtp-Source: AGHT+IE19FGJUWTXwSf/NGdbRhow1ns69zJifMgbHVd98NdglNlOqXX2eh3suahpJqWVIKPFEag5S6o044b+qXqw8YA=
X-Received: by 2002:a17:902:fccb:b0:1d9:c0e3:3f5e with SMTP id
 mi11-20020a170902fccb00b001d9c0e33f5emr348376plb.25.1708342583148; Mon, 19
 Feb 2024 03:36:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rodrigo Queiro <rodrigoq@google.com>
Date: Mon, 19 Feb 2024 12:36:12 +0100
Message-ID: <CAMnS4ZDigjkexNdJT3ZhLcmAMeodTKsPi+b91sSjE5sky7ZfqQ@mail.gmail.com>
Subject: Alternative to updating has_smi_counter?
To: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I observed that `cyclictest --smi` doesn't work on Raptor Lake CPUs
(including 13th gen Intel Core CPUs). I assume that this could be
resolved by extending the switch statements in has_smi_counter(). Last
time this was done, the author changed the structure to better match
turbostat.c, but that has since been refactored to a table/struct
approach that is less easily copied.

I also notice that if family == 6, all listed CPUs support the SMI
counter, both in cyclictest.c and turbostat.c. Only unrecognized CPUs
cause has_smi_counter() to return 0 if family == 6, even though it is
more likely that the CPU is newer than the list in cyclictest.c, as
opposed to a CPU from 2008 or earlier.

What do you think about removing the checks on the model number, and
assuming that all processors with family == 6 support the Nehalem
MSRs, including the SMI counter? Any user running a recent cyclictest
on pre-Nehalem hardware could still run without --smi to prevent
seeing bogus SMI counts.

Thanks in advance,
Rodrigo
