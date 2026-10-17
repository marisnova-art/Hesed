-- STREAMING_CHUNK:Creating Table Structures...
-- 1. Create site_content Table for Internationalized Multi-language Texts
CREATE TABLE IF NOT EXISTS public.site_content (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    key VARCHAR(255) UNIQUE NOT NULL,
    content_ko TEXT NOT NULL,
    content_en TEXT NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Create site_media Table for Dynamic Studio Images & Assets
CREATE TABLE IF NOT EXISTS public.site_media (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    element_id VARCHAR(255) UNIQUE NOT NULL,
    image_url TEXT NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- STREAMING_CHUNK:Enabling Row Level Security Policies...
-- 3. Enable Row Level Security (RLS)
ALTER TABLE public.site_content ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.site_media ENABLE ROW LEVEL SECURITY;

-- 4. READ PERMISSION: Everyone (Public Users) can READ content & media
CREATE POLICY "Allow public read access for site_content"
ON public.site_content FOR SELECT
USING (true);

CREATE POLICY "Allow public read access for site_media"
ON public.site_media FOR SELECT
USING (true);

-- 5. WRITE PERMISSION: Only Authenticated Admins can INSERT/UPDATE/DELETE
CREATE POLICY "Allow admin write access for site_content"
ON public.site_content FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY "Allow admin write access for site_media"
ON public.site_media FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);