Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A562A1B
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jan 2024 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099327; cv=none; b=qmNiMRyZUlEt6PHuhYwrBadR44xg1/oTamC4y63NX7TOWJNghSPrJYjHepi3lQOJdUe7A3VYTEnlrHPSx3tvQKJ6DgwidxaV6fSKsRkd5DcJXtDuSSI7WplX/kNrXhj7Sg25TNYPbjgJy6ftIcncCTkWwFJ2j4avuhGmjbHHrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099327; c=relaxed/simple;
	bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=V0ELbfTeLVretlIdQwZSOLIstTgzs/Xd+EluhCCSqRA7cm2IrlLFEXSZi6YZ9XkJ9Zpt7XG4SPdff8z8fPWgWfC6iZWHpEuURO6nC+eshxF4XAF+ICDtbd0NRKBL/tJ1IUg5VehT1GYTVKPhNM5YHluix4Q3LA8xwIOraLJ7eQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB4D6MV/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB4D6MV/"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso4509538a12.2
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Jan 2024 04:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706099325; x=1706704125; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=TB4D6MV/gW8RcTtmw6cNWiWA5411XUFQ6jHQGhOraOTDYyiEnxWtg5G7P8OqPdU4hb
         AxaEiBxlUsk4V6nIQPBC+lfB56iRIy/5LJhhTrHbdsrMSyqve5u3Uu89PORbWPG5LR+Y
         8/+dCURDewbEds4hmcwoCmCRlqK5n2X5CNGGalF2y5r8Ubkoa/Ttw9CCcLBJdFiGy/dv
         Bl0MFCpWQJRomQo+HCsLh+UisTVLzMc6IC1yGQot1zQFdsIM1mxok72r7hU7l1xVWnOq
         eAro1x5TZmaM5PzgUbY5Dhl8kaJGuS3SOuA4EM5R4OWILMz83XjiN+Nq0UAtjKIETzND
         2eXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099325; x=1706704125;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=UoNfXkChem35bn0rnXl0rGpVFYFtQS54RRNx3MVSvO4NAuMWdvHpoRAy5l4E4ZYg9C
         HrMxgUoWHENH0RHAGHFznNCfpVRWeq+oFL3k2wqVzA/rykXKEvz+iHzw2GNfajA0tL0I
         4ScmQeb39aplRb7y0R3USaHx8bGvxPK7FUKXpJOJp11y71BymD8JETGJhQP7UuVjWbpz
         XIUKWcovmmY0YRsc5UZqZ5S2aJcZlLRX1ACkpbVB4kN9dM0WQyYuaxbC6YUUrD9ixJaO
         TElUutOOxvmdKz0eHke3xQIHCW//mOztaZNbcUQDgp0mAkYKHtLfhDDrf02kHz9bjC82
         VKTA==
X-Gm-Message-State: AOJu0YyAGQdzDpf9XdS8GtgohpAVektXNLxVZJtvXXdiBw/oTw5rHv9L
	BCy6Oyhol6ZpxoMU4KH5ir4UG1sgbfJup8x0ezkwjJ35kJZwMALpVbZr+wzV+gzcmd8X6VNridP
	2xOIUxXMdbSJacX0sqPDMGs8jYxO/jVAesyA=
X-Google-Smtp-Source: AGHT+IFY4uWP6ynP4+fy/cYkW9gzIl4IAtBYB4xI9Y4hgZ/Fs+j1ttayJ+hri9yi/l88giHA0pwc0x6bZSxwvyJ2YvY=
X-Received: by 2002:a05:6a20:4da6:b0:199:9c7e:a58b with SMTP id
 gj38-20020a056a204da600b001999c7ea58bmr749537pzb.118.1706099325459; Wed, 24
 Jan 2024 04:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5p2o5pil5Yip?= <z0node@gmail.com>
Date: Wed, 24 Jan 2024 20:28:34 +0800
Message-ID: <CAGDYfxCm1ci2m85-rNa+JvhhCvT=RwrYvvSwxLyW4pPdhRo39g@mail.gmail.com>
Subject: unsubscribe linux-kernel
To: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

unsubscribe linux-kernel
